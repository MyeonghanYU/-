// .env(또는 호스팅의 환경변수)를 읽어 dist/index.html 에 Supabase 설정을 채워 넣습니다.
import { readFileSync, writeFileSync, mkdirSync, existsSync } from "node:fs";

const env = { ...process.env };
if (existsSync(".env")) {
  for (const line of readFileSync(".env", "utf8").split(/\r?\n/)) {
    const m = line.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*?)\s*$/);
    if (m && !line.trim().startsWith("#") && env[m[1]] === undefined) env[m[1]] = m[2].replace(/^["']|["']$/g, "");
  }
}

const keys = ["SUPABASE_URL", "SUPABASE_PUBLISHABLE_KEY"];
const missing = keys.filter((k) => !env[k]);
if (missing.length) {
  console.error(`환경변수가 없습니다: ${missing.join(", ")}  (.env 파일을 확인하세요)`);
  process.exit(1);
}

let html = readFileSync("index.html", "utf8");
for (const k of keys) html = html.replaceAll(`%${k}%`, env[k]);

mkdirSync("dist", { recursive: true });
writeFileSync("dist/index.html", html);
console.log("dist/index.html 생성 완료");
