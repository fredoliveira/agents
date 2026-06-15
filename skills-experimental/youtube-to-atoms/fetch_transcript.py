#!/usr/bin/env python3
"""
Fetch a single YouTube video's transcript → one markdown file with frontmatter,
ready for atomic-note extraction. No API key (uses yt-dlp + on-page captions).

  python3 fetch_transcript.py "https://www.youtube.com/watch?v=VIDEOID"
  python3 fetch_transcript.py "<url>" --out-dir /path/to/Transcripts

Prints the absolute path of the transcript file it wrote (or that already
existed). Exits non-zero with a message if the video has no usable captions.
"""
import argparse, json, os, re, sys, time, urllib.request, urllib.error, datetime
from pathlib import Path

UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/124.0 Safari/537.36")


def http_get_json(url, retries=4):
    """GET JSON with a browser UA and exponential backoff on 429 throttling."""
    for attempt in range(retries):
        req = urllib.request.Request(url, headers={"User-Agent": UA})
        try:
            return json.load(urllib.request.urlopen(req))
        except urllib.error.HTTPError as e:
            if e.code == 429 and attempt < retries - 1:
                wait = 5 * (2 ** attempt)  # 5s, 10s, 20s
                print(f"  throttled (429), retrying in {wait}s…", file=sys.stderr)
                time.sleep(wait)
                continue
            raise

DEFAULT_OUT = os.environ.get(
    "YT_VAULT", str(Path.home() / "Documents/obsidian/yt")
) + "/Transcripts"


def slug(s, n=60):
    s = re.sub(r"[^\w\s-]", "", s.lower()).strip()
    return re.sub(r"[\s_]+", "-", s)[:n].strip("-") or "untitled"


def ts(ms):
    sec = int((ms or 0) / 1000)
    h, m, s = sec // 3600, (sec % 3600) // 60, sec % 60
    return f"{h}:{m:02d}:{s:02d}" if h else f"{m}:{s:02d}"


def caption_url(info):
    """Prefer manual English captions, fall back to auto-generated; want json3."""
    subs, auto = info.get("subtitles") or {}, info.get("automatic_captions") or {}
    for src, manual in ((subs, True), (auto, False)):
        for lang in ("en", "en-US", "en-GB", "en-orig"):
            for fmt in src.get(lang, []):
                if fmt.get("ext") == "json3":
                    return fmt["url"], manual
    return None, None


def transcript_body(json3_url):
    data = http_get_json(json3_url)
    paras, cur, start, words = [], [], None, 0
    for e in data.get("events", []):
        text = "".join(s.get("utf8", "") for s in (e.get("segs") or []))
        text = re.sub(r"\s+", " ", text).strip()
        if not text:
            continue
        if start is None:
            start = e.get("tStartMs")
        cur.append(text)
        words += len(text.split())
        if words >= 110:
            paras.append(f"**[{ts(start)}]** {' '.join(cur)}")
            cur, start, words = [], None, 0
    if cur:
        paras.append(f"**[{ts(start)}]** {' '.join(cur)}")
    return "\n\n".join(paras)


def yesc(s):
    return '"' + str(s).replace("\\", "\\\\").replace('"', '\\"') + '"'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("url")
    ap.add_argument("--out-dir", default=DEFAULT_OUT)
    a = ap.parse_args()

    try:
        import yt_dlp
    except ImportError:
        sys.exit("ERROR: yt-dlp not installed. Run: python3 -m pip install yt-dlp")

    out = Path(a.out_dir)
    out.mkdir(parents=True, exist_ok=True)

    with yt_dlp.YoutubeDL({"skip_download": True, "quiet": True,
                           "no_warnings": True, "extractor_retries": 2}) as ydl:
        info = ydl.extract_info(a.url, download=False)

    vid = info.get("id")
    existing = list(out.glob(f"*-{vid}.md"))
    if existing:
        print(str(existing[0].resolve()))
        return

    url, manual = caption_url(info)
    if not url:
        sys.exit(f"ERROR: no English captions available for {a.url}")
    try:
        body = transcript_body(url)
    except urllib.error.HTTPError as e:
        if e.code == 429:
            sys.exit("ERROR: throttled by YouTube (429) after retries. "
                     "Wait a few minutes and run again.")
        raise

    title = info.get("title", vid)
    channel = info.get("uploader") or info.get("channel") or ""
    dur = info.get("duration") or 0
    duration = f"{dur//3600}:{(dur%3600)//60:02d}:{dur%60:02d}" if dur >= 3600 \
        else f"{dur//60}:{dur%60:02d}"
    watch_url = f"https://www.youtube.com/watch?v={vid}"
    path = out / f"{slug(title)}-{vid}.md"

    fm = [
        "---",
        f"title: {yesc(title)}",
        "source: youtube",
        f"url: {watch_url}",
        f"videoId: {vid}",
        f"channel: {yesc(channel)}",
        f"duration: {duration}",
        f"captions: {'manual' if manual else 'auto'}",
        f"extractedAt: {datetime.datetime.now().strftime('%Y-%m-%d')}",
        "type: source/transcript",
        "status: unprocessed",
        "tags: [transcript, youtube]",
        "---",
        "",
        f"# {title}",
        "",
        f"> [{channel}]({watch_url}) · {duration}",
        "",
        body,
        "",
    ]
    path.write_text("\n".join(fm))
    print(str(path.resolve()))


if __name__ == "__main__":
    main()
