SELECT * FROM copang_main.member WHERE address LIKE "%고양시%"; // ~ + 고양시 + ~ : 고양시가 포함된 주소

SELECT * FROM copang_main.member WHERE age IN (25, 34); // age가 25, 34인 멤버만

SELECT * FROM copang_main.member WHERE email LIKE "c_____@%"; // c + 5글자 + @ + ~

SELECT * FROM copang_main.member WHERE YEAR(birthday) = "1992";

SELECT * FROM copang_main.member WHERE MONTH(sign_up_day) IN (6, 7, 8);

SELECT * FROM copang_main.member WHERE DAYOFMONTH(sign_up_day) BETWEEN 15 AND 31;

SELECT email, sign_up_day, DATEDIFF(sign_up_day, "2019-01-01") FROM copang_main.member;

SELECT email, sign_up_day, DATEDIFF(sign_up_day, CURDATE()) FROM copang_main.member; // CURDATE() : 오늘 날짜

SELECT email, sign_up_day, birthday, DATEDIFF(sign_up_day, birthday) / 365 FROM copang_main.member;

SELECT email, sign_up_day, birthday, DATE_ADD(sign_up_day, INTERVAL 300 DAY) FROM copang_main.member; // 기준으로부터 +300일 

SELECT email, sign_up_day, birthday, DATE_SUB(sign_up_day, INTERVAL 250 DAY) FROM copang_main.member; // 기준으로부터 -250일

SELECT email, sign_up_day, birthday, UNIX_TIMESTAMP(sign_up_day) FROM copang_main.member; // 1970년 1월 1일을 기준으로, 총 몇 초가 지났는지를 나타냄.

SELECT email, sign_up_day, birthday, FROM_UNIXTIME(UNIX_TIMESTAMP(sign_up_day)) FROM copang_main.member;

// 나머지는 mysql document 참고

SELECT * FROM copang_main.member
	WHERE gender = "m"
		AND address LIKE "서울%"
		AND age BETWEEN 25 and 29;

SELECT * FROM copang_main.member
WHERE MONTH(sign_up_day) BETWEEN 3 AND 5
	OR MONTH(sign_up_day) BETWEEN 9 AND 11;

SELECT * FROM copang_main.member
WHERE (gender = "m" AND height >= 180) 
	OR (gender = "f" AND height >= 170)

** 실수 주의
SELECT * FROM copang_main.member WHERE id = 1 OR id = 2 (O)
SELECT * FROM copang_main.member WHERE id = 1 OR 2 (X) // MYSQL은 0만 False > 2는 True로 판단되어 결과적으로 모든 row가 출력된다.

SELECT id, email, age, sign_up_day FROM member 
    WHERE age BETWEEN 20 AND 29 
        AND MONTH(sign_up_day) = 7