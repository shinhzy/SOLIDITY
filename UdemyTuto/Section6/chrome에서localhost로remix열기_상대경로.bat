@echo on

START remixd -s . -u https://remix.ethereum.org
::현재 디렉토리를 localhost로 remix 연결
timeout 5
::5초 대기
START chrome https://remix.ethereum.org
::크롬 remix 실행

::pause 없으므로 cmd 꺼질 것
