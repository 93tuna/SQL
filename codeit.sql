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

SELECT * FROM copang_main.member WHERE sentence LIKE "%\%%" // \ > 이스케이핑 (뒤에 오는 것이 문자로 인식되도록)

SELECT * FROM copang_main.member WHERE sentence LIKE BINARY "%g%"
SELECT * FROM copang_main.member WHERE sentence LIKE BINARY "%G%" // BINARY : 이진수까지 동일
// Table info에서 Table collation의 ci : case-insensitive는 대소문자의 구분을 하지 않는다는 뜻.

SELECT * FROM copang_main.member
ORDER BY height ASC; // ASC : 오름차순 (Null이 있을시 가장 작은 값으로 취급됨.)

SELECT * FROM copang_main.member
ORDER BY height DESC;

SELECT sign_up_day, email FROM copang_main.member
ORDER BY YEAR(sign_up_day) DESC, email ASC;

SELECT * FROM ~
ORDER BY CAST(data AS signed) ASC; // signed : 정수 CAST(data AS ~ ) : 데이터타입을 일시적으로 , demical ...

SELECT * FROM copang_main.member
ORDER BY sign_up_day DESC
LIMIT 10; // 10개의 로우만 선택

SELECT * FROM copang_main.member
ORDER BY sign_up_day DESC
LIMIT 8, 2; // 9번째 로우부터 2개만 선택

SELECT COUNT(height) FROM copang_main.member; // Null값이 제외되므로 row수를 알고 싶으면 *로
SELECT COUNT(*) FROM copang_main.member;

SELECT MAX(height) FROM copang_main.member;
SELECT MIN(height) FROM copang_main.member;
SELECT AVG(height) FROM copang_main.member; // Null 제외
// SUM, STD, ABS, SQRT, CEIL, FLOOR, ROUND (합, 표준편차, 절대값, 제곱근, 올림, 내림, 반올림)

SELECT * FROM copang_main.member WHERE address IS NULL; // NULL만
SELECT * FROM copang_main.member WHERE address IS NOT NULL; // NULL 제외

SELECT * FROM copang_main.member
WHERE height IS NULL
	OR weight IS NULL
    OR address IS NULL;

SELECT 
	COALESCE(height, "####"),
    COALESCE(weight, "---"),
    COALESCE(address, "@@@")
FROM copang_main.member;

SELECT AVG(age) FROM copang_main.member WHERE age BETWEEN 5 AND 100;
SELECT * FROM copang_main.member WHERE address NOT LIKE "%호"; (이상한 주소들만)

SELECT COUNT(*), ROUND(AVG(star)) FROM review
WHERE comment IS NOT NULL

SELECT email, height AS 키, weight AS 몸무게, weight / (height/100) / (height/100) AS BMI FROM copang_main.member

SELECT email, 
		CONCAT(height, "cm", ", ", weight, "kg") AS "키와 몸무게", 
        weight / (height/100) / (height/100) AS BMI 
FROM copang_main.member

SELECT 
		email, 
		CONCAT(height, "cm", ", ", weight, "kg") AS "키와 몸무게", 
        weight / (height/100) / (height/100) AS BMI,
        
(CASE
	WHEN weight IS NULL OR height is NULL THEN "비만 여부 알 수 없음."
    WHEN weight / (height/100) / (height/100) >= 25 THEN "과체중 또는 비만"
    WHEN weight / (height/100) / (height/100) >= 18.5
		AND weight / (height/100) / (height/100) < 25
        THEN "정상"
	ELSE "저체중"
END) AS obesity_check

FROM copang_main.member
ORDER BY obesity_check ASC;


