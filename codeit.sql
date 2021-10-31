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

// COALESCE은 인자중에서 가장 첫번째로 NULL이 아닌 값을 반환하고, IFNULL은 첫번째 인자가 NULL일 경우 두번째 인자를 반환하는 차이가 있다.
// 또한, COALESCE는 표준 SQL 함수이고, IFNULL은 MYSQL 함수이다.
SELECT COALESCE(height, weight * 2.3, "N/A") FROM copang_main.member;
SELECT IFNULL(height, "N/A") FROM copang_main.member;
SELECT IF(height IS NOT NULL, height, "N/A") FROM copang_main.member;

SELECT
	CASE
		WHEN height IS NOT NULL THEN height
		ELSE "N/A"
	END
FROM copang_main.member

SELECT name, price, price/cost,
    (CASE
        WHEN price/cost >= 1 AND price/cost < 1.5 THEN "C. 저효율 메뉴"
        WHEN 1.5 <= price/cost AND price/cost < 1.7 THEN "B. 중효율 메뉴"
        WHEN price/cost >= 1.7 THEN "A. 고효율 메뉴"
    END) AS efficiency
FROM pizza_price_cost
ORDER BY efficiency DESC, price ASC
LIMIT 6;

SELECT DISTINCT(gender) FROM copang_main.member
SELECT DISTINCT(SUBSTRING(address, 1, 2)) FROM copang_main.member // SUBSTRING > address에서 1번째 문자부터 시작해서 2개만 선택
SELECT COUNT(DISTINCT(SUBSTRING(address, 1, 2))) FROM copang_main.member

SELECT *, LENGTH(address) FROM copang_main.member
// UPPER, LOWER

SELECT LPAD(age, 10, 0) FROM copang_main.member // 왼쪽을 3번째 인자로 두번째 인자만큼 채운다.
SELECT RPAD(age, 10, "!") FROM copang_main.member // 오른쪽을 ``

// TRIM LTRIM RTRIM 공백 제거 (좌우, 좌, 우)

SELECT gender, COUNT(*), AVG(height), MIN(weight) FROM copang_main.member GROUP BY gender

SELECT 
	SUBSTRING(address, 1, 2) AS region, 
    gender,
    COUNT(*) AS cnt
FROM copang_main.member 
GROUP BY 
	SUBSTRING(address, 1, 2),
	gender
HAVING 
	region = "서울"
	AND gender = "m"

SELECT 
	SUBSTRING(address, 1, 2) AS region, 
    gender,
    COUNT(*) AS cnt,
	AVG(age)
FROM copang_main.member 
GROUP BY 
	SUBSTRING(address, 1, 2),
	gender
HAVING 
	region IS NOT NULL
ORDER BY 
	region ASC,
    gender DESC;

// WHERE, HAVING 차이 구별하기. WHERE은 SELECT를 할 때 부터 필터링 하는 것이고, HAVING은 이미 SELECT 된 후의 GROUP들을 필터링 하는 것.
**** SELECT에는 그루핑의 기준으로 사용한 컬럼명만이 와야 한다! (집계 함수는 가능)

(1) GROUP BY 절 뒤에 쓴 컬럼 이름들만, SELECT 절 뒤에도 쓸 수 있다.

(2) 대신 SELECT 절 뒤에서 집계 함수에 그 외의 컬럼 이름을 인자로 넣는 것은 허용된다.

!!!! 중요 !!!!
작성시 순서와 실제 해석 및 실행 순서가 다르다!
SELECT 
FROM
WHERE
GROUP BY
HAVING 
ORDER BY
LIMIT 

FROM : 어느 테이블을 대상으로 할 것인지를 먼저 결정합니다. 
WHERE : 해당 테이블에서 특정 조건(들)을 만족하는 row들만 선별합니다. 
GROUP BY : row들을 그루핑 기준대로 그루핑합니다. 하나의 그룹은 하나의 row로 표현됩니다.
HAVING : 그루핑 작업 후 생성된 여러 그룹들 중에서, 특정 조건(들)을 만족하는 그룹들만 선별합니다. 
SELECT : 모든 컬럼 또는 특정 컬럼들을 조회합니다. SELECT 절에서 컬럼 이름에 alias를 붙인 게 있다면, 이 이후 단계(ORDER BY, LIMIT)부터는 해당 alias를 사용할 수 있습니다.
ORDER BY : 각 row를 특정 기준에 따라서 정렬합니다. 
LIMIT : 이전 단계까지 조회된 row들 중 일부 row들만을 추립니다. 

select 
    category, 
    main_month, 
    count(*) as "영화 수", 
    sum(view_count) as "총 관객 수"
from 2020_movie_report
group by category, main_month
having main_month = 5
    and sum(view_count) >= 3000000

SELECT 
	SUBSTRING(address, 1, 2) AS region, 
    gender,
    COUNT(*) AS cnt,
	AVG(age)
FROM copang_main.member 
GROUP BY 
	SUBSTRING(address, 1, 2),
	gender
WITH ROLLUP // 상위 기준(region)을 기준으로 세부 그룹을 합쳐준다고 생각
HAVING 
	region IS NOT NULL
ORDER BY 
	region ASC,
    gender DESC;

SELECT YEAR(birthday) AS b_year, YEAR(sign_up_day) AS s_year, gender, COUNT(*)
FROM copang_main.member
GROUP BY YEAR(birthday), YEAR(sign_up_day), gender WITH ROLLUP
ORDER BY b_year DESC;

SELECT YEAR(sign_up_day) AS s_year, gender, SUBSTRING(address, 1, 2) AS region, 
	GROUPING(YEAR(sign_up_day)), GROUPING(gender), GROUPING(SUBSTRING(address, 1, 2)), COUNT(*)
FROM copang_main.member
GROUP BY YEAR(sign_up_day), gender, SUBSTRING(address, 1, 2) WITH ROLLUP
ORDER BY s_year DESC;

(1) 실제로 NULL을 나타내기 위해 쓰인 NULL인 경우에는 0,

(2) 부분 총계를 나타내기 위해 표시된 NULL은 1

