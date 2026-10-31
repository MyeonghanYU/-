-- 세무사 유명한 소개 페이지 콘텐츠 테이블
-- Table Editor에서 내용을 고치면 사이트에 바로 반영됩니다.

-- 1) 크리에이터 고민
create table if not exists public.worries (
  id         bigint generated always as identity primary key,
  sort_order int  not null default 0,
  question   text not null,
  answer     text not null
);

-- 2) 서비스
create table if not exists public.services (
  id          bigint generated always as identity primary key,
  sort_order  int  not null default 0,
  tag         text not null,
  title       text not null,
  description text not null
);

-- 3) 자주 묻는 질문
create table if not exists public.faqs (
  id         bigint generated always as identity primary key,
  sort_order int  not null default 0,
  question   text not null,
  answer     text not null
);

-- 보안: 방문자는 읽기만 가능 (수정은 대시보드에서만)
alter table public.worries  enable row level security;
alter table public.services enable row level security;
alter table public.faqs     enable row level security;

drop policy if exists "public read" on public.worries;
drop policy if exists "public read" on public.services;
drop policy if exists "public read" on public.faqs;
create policy "public read" on public.worries  for select to anon, authenticated using (true);
create policy "public read" on public.services for select to anon, authenticated using (true);
create policy "public read" on public.faqs     for select to anon, authenticated using (true);

-- 현재 사이트 내용으로 채우기
truncate public.worries, public.services, public.faqs restart identity;

insert into public.worries (sort_order, question, answer) values
(1, '애드센스 수익이 달러로 들어오는데, 이것도 신고해야 하나요?', '해외 플랫폼 수익도 국내 사업소득입니다. 입금 시점 환율 기준으로 수입을 정리하고, 빠진 금액 없이 신고합니다.'),
(2, '협찬으로 받은 제품도 소득으로 잡히나요?', '대가성 협찬은 현물이라도 수입에 해당할 수 있습니다. 광고 계약서와 세금계산서 흐름을 함께 점검합니다.'),
(3, '카메라, 조명, 편집 PC 산 것도 경비가 되나요?', '사업 관련 지출이라면 경비 처리가 가능합니다. 감가상각 대상인지, 증빙은 충분한지 기준을 잡아 드립니다.'),
(4, 'MCN에서 3.3% 떼고 줬는데, 그걸로 끝 아닌가요?', '3.3%는 미리 낸 세금입니다. 5월 종합소득세 신고로 최종 세액을 정산해야 하고, 경비가 많으면 환급받을 수도 있습니다.'),
(5, '사업자등록은 언제, 어떤 업종으로 해야 하나요?', '수익이 반복적으로 생기기 시작했다면 등록을 검토할 때입니다. 장비와 작업 공간에 따라 업종코드가 달라집니다.'),
(6, '수익이 많이 늘었는데, 법인으로 바꾸는 게 나을까요?', '소득 규모, 향후 계획, 가족 고용 여부에 따라 달라집니다. 개인과 법인의 세 부담을 숫자로 비교해 드립니다.');

insert into public.services (sort_order, tag, title, description) values
(1, 'START', '사업자등록 · 업종 설계', '작업 환경에 맞는 업종코드를 고르고, 간이·일반·면세 중 유리한 유형을 판단합니다.'),
(2, 'MAY', '종합소득세 신고', '플랫폼 수익, 광고·협찬, 강의 수익을 한 번에 모아 신고하고 3.3% 원천징수분을 정산합니다.'),
(3, 'JAN · JUL / FEB', '부가세 · 사업장현황신고', '과세사업자는 부가세 신고와 매입세액 공제를, 면세사업자는 사업장현황신고를 챙깁니다.'),
(4, 'MONTHLY', '월 기장 · 경비 관리', '장비, 소품, 편집·썸네일 외주비, 스튜디오 임차료를 매달 정리해 놓치는 경비를 줄입니다.'),
(5, 'CONTRACT', '광고 · 협찬 계약 세무 검토', '브랜드 광고, PPL, 공동구매 수익의 세금계산서 발행과 소득 구분을 정리합니다.'),
(6, 'GROWTH', '법인 전환 · 세무조사 대응', '법인 설립 시점과 방법을 설계하고, 소명 요청이나 세무조사가 오면 직접 대응합니다.');

insert into public.faqs (sort_order, question, answer) values
(1, '구독자가 적은 초기 채널도 상담 가능한가요?', '네. 수익화 직후가 업종과 사업자 유형을 정하기 가장 좋은 시기입니다. 처음부터 맞게 세팅하면 나중에 정정할 일이 줄어듭니다.'),
(2, '지방에 살아도 맡길 수 있나요?', '상담부터 자료 전달, 신고까지 모두 비대면으로 진행합니다. 필요하면 화상 미팅도 가능합니다.'),
(3, '지난 몇 년간 신고를 안 했는데 어떻게 하나요?', '기한후신고나 경정청구로 바로잡을 수 있습니다. 빨리 정리할수록 가산세 부담이 줄어드니 먼저 상황부터 알려 주세요.'),
(4, '회사에 다니면서 유튜브를 하고 있어요.', '근로소득과 사업소득을 합산해 5월에 종합소득세를 신고해야 합니다. 겸업 상황에 맞춰 신고 방법을 안내해 드립니다.'),
(5, '비용은 어떻게 되나요?', '수익 규모와 필요한 업무 범위에 따라 다릅니다. 무료 상담 후 정확한 견적을 안내해 드립니다.');
