#!/bin/bash
# Double-click this file to open the 3D portfolio locally.
#
# The page MUST be served over http:// — opening index.html directly from Finder
# (file://) is blocked by the browser's CORS policy, so the 3D viewers stay empty.

cd "$(dirname "$0")" || exit 1

PORT=8899
while lsof -i :$PORT >/dev/null 2>&1; do
  PORT=$((PORT + 1))
done

echo "Serving the 3D portfolio at http://localhost:$PORT"
echo "Leave this window open while you browse. Press Ctrl+C to stop."

/usr/bin/python3 -m http.server "$PORT" >/dev/null 2>&1 &
SERVER_PID=$!

trap 'kill $SERVER_PID 2>/dev/null' EXIT INT TERM

sleep 1
/usr/bin/open "http://localhost:$PORT/index.html"

wait $SERVER_PID
