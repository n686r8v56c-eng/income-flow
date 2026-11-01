# Income Flow — React + Vite + Supabase + Cloudflare Pages

실제 React 앱입니다. `index.html` 단일 파일 방식이 아닙니다.

## 1. Supabase

1. 새 Supabase 프로젝트 생성
2. SQL Editor에서 `supabase.sql` 실행
3. Authentication → Providers → Email 활성화
4. Project URL과 Publishable Key 확인 (service_role/secret 키 사용 금지)

## 2. 로컬 실행

```bash
npm install
cp .env.example .env
# .env 파일에 실제 VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY 입력
npm run dev
```

## 3. Cloudflare Pages

GitHub 저장소에 이 프로젝트 폴더 **안의 파일들**을 업로드합니다.

- Framework preset: **Vite**
- Build command: `npm run build`
- Build output directory: `dist`
- Environment variables: `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`

Supabase Authentication → URL Configuration에서 Cloudflare Pages 배포 URL을 Site URL/Redirect URLs에 등록합니다.

## 4. 주의사항

- 사용자별 RLS 적용. 계정별 JSON 상태를 Supabase 한 행에 저장합니다.
- 동시 다중 기기 편집 시 마지막 저장이 우선합니다. 같은 계정을 두 기기에서 동시에 편집하지 마세요.
- 매출/수금은 현재 총액 기준이며, 건별 수금 배분·수수료 정산은 아직 구현되지 않았습니다.
- 이전 단일 HTML 버전의 localStorage 데이터를 자동 이전하지 않습니다. 별도 백업 데이터 검증이 필요합니다.
- Cloudflare와 Supabase 실환경 인증은 프로젝트 URL/키가 없어 아직 검증하지 않았습니다.

## 연결된 프로젝트 설정
이 배포본은 사용자가 제공한 Supabase Project URL 및 publishable key가 `.env.production`에 설정되어 있습니다. `npm run build` 시 Vite가 자동으로 읽습니다. 공개 가능한 publishable key만 포함되어 있으며 secret/service_role 키는 포함되지 않습니다.
Cloudflare Pages에서 환경 변수를 별도로 설정하면 그 값이 우선할 수 있으므로 프로젝트 값이 일치하는지 확인하세요. Supabase SQL Editor에서 `supabase.sql`을 실행하고 Authentication → URL Configuration에 실제 배포 도메인을 등록해야 합니다.
