
-- ████████  █████   █     █ 
--   █ █   ██    █  █     ██ 
--   █ █████ ███ ███       █ 
--   █ █   █    ██  █      █ 
--   █ █   █████ █   █     █ 
-- ===================== ====================
-- 1. 用戶資料，資料表為 USER

-- 1. 新增：新增六筆用戶資料，資料如下：
--     1. 用戶名稱為`李燕容`，Email 為`lee2000@hexschooltest.io`，Role為`USER`
--     2. 用戶名稱為`王小明`，Email 為`wXlTq@hexschooltest.io`，Role為`USER`
--     3. 用戶名稱為`肌肉棒子`，Email 為`muscle@hexschooltest.io`，Role為`USER`
--     4. 用戶名稱為`好野人`，Email 為`richman@hexschooltest.io`，Role為`USER`
--     5. 用戶名稱為`Q太郎`，Email 為`starplatinum@hexschooltest.io`，Role為`USER`
--     6. 用戶名稱為 透明人，Email 為 opacity0@hexschooltest.io，Role 為 USER
INSERT INTO "USER"(name,email,role)
VALUES
	('李燕容','lee2000@hexschooltest.io','USER'),
	('王小明','wXlTq@hexschooltest.io','USER'),
	('肌肉棒子','muscle@hexschooltest.io','USER'),
	('好野人','richman@hexschooltest.io','USER'),
	('Q太郎','starplatinum@hexschooltest.io','USER'),
	('透明人','opacity0@hexschooltest.io','USER');

-- 1-2 修改：用 Email 找到 李燕容、肌肉棒子、Q太郎，如果他的 Role 為 USER 將他的 Role 改為 COACH
update "USER" 
set "role" = 'COACH'
where email in ('lee2000@hexschooltest.io','muscle@hexschooltest.io','starplatinum@hexschooltest.io') and "role" = 'USER';

-- 1-3 刪除：刪除USER 資料表中，用 Email 找到透明人，並刪除該筆資料
delete from "USER" 
where email = 'opacity0@hexschooltest.io';

-- 1-4 查詢：取得USER 資料表目前所有用戶數量（提示：使用count函式）
select count(*) as 所有用戶數量 from "USER";

-- 1-5 查詢：取得 USER 資料表所有用戶資料，並列出前 3 筆（提示：使用limit語法）
select * from "USER" limit 3;

--  ████████  █████   █    ████  
--    █ █   ██    █  █         █ 
--    █ █████ ███ ███       ███  
--    █ █   █    ██  █     █     
--    █ █   █████ █   █    █████ 
-- ===================== ====================
-- 2. 組合包方案 CREDIT_PACKAGE、客戶購買課程堂數 CREDIT_PURCHASE
-- 2-1. 新增：在`CREDIT_PACKAGE` 資料表新增三筆資料，資料需求如下：
    -- 1. 名稱為 `7 堂組合包方案`，價格為`1,400` 元，堂數為`7`
    -- 2. 名稱為`14 堂組合包方案`，價格為`2,520` 元，堂數為`14`
    -- 3. 名稱為 `21 堂組合包方案`，價格為`4,800` 元，堂數為`21`
insert into "CREDIT_PACKAGE"("name","price","credit_amount")
values
	('7 堂組合包方案',1400,7),
	('14 堂組合包方案',2520,14),
	('21 堂組合包方案',4800,21);

-- 2-2. 新增：在 `CREDIT_PURCHASE` 資料表，新增三筆資料：（請使用 name 欄位做子查詢）
    -- 1. `王小明` 購買 `14 堂組合包方案`
    -- 2. `王小明` 購買 `21 堂組合包方案`
    -- 3. `好野人` 購買 `14 堂組合包方案`
insert into "CREDIT_PURCHASE"("user_id","credit_package_id","purchased_credits","price_paid")
values
	(
		(select id from "USER" where name = '王小明'),
		(select id from "CREDIT_PACKAGE" where name = '14 堂組合包方案'),
		(select credit_amount from "CREDIT_PACKAGE" where name = '14 堂組合包方案'),
		(select price from "CREDIT_PACKAGE" where name = '14 堂組合包方案')
	),
	(
		(select id from "USER" where name = '王小明'),
		(select id from "CREDIT_PACKAGE" where name = '21 堂組合包方案'),
		(select credit_amount from "CREDIT_PACKAGE" where name = '21 堂組合包方案'),
		(select price from "CREDIT_PACKAGE" where name = '21 堂組合包方案')
	),
	(
		(select id from "USER" where name = '好野人'),
		(select id from "CREDIT_PACKAGE" where name = '14 堂組合包方案'),
		(select credit_amount from "CREDIT_PACKAGE" where name = '14 堂組合包方案'),
		(select price from "CREDIT_PACKAGE" where name = '14 堂組合包方案')
	);

-- ████████  █████   █    ████   
--   █ █   ██    █  █         ██ 
--   █ █████ ███ ███       ███   
--   █ █   █    ██  █         ██ 
--   █ █   █████ █   █    ████   
-- ===================== ====================
-- 3. 教練資料 ，資料表為 COACH ,SKILL,COACH_LINK_SKILL
-- 3-1 新增：在`COACH`資料表新增三筆教練資料，資料需求如下：
    -- 1. 將用戶`李燕容`新增為教練，並且年資設定為2年（提示：使用`李燕容`的email ，取得 `李燕容` 的 `id` ）
    -- 2. 將用戶`肌肉棒子`新增為教練，並且年資設定為2年
    -- 3. 將用戶`Q太郎`新增為教練，並且年資設定為2年
insert into "COACH"(user_id,experience_years)
values
	((select id from "USER" where email = 'lee2000@hexschooltest.io'),2),
	((select id from "USER" where email = 'muscle@hexschooltest.io'),2),
	((select id from "USER" where email = 'starplatinum@hexschooltest.io'),2);

-- 3-2. 新增：承1，為三名教練新增專長資料至 `COACH_LINK_SKILL` ，資料需求如下：
    -- 1. 所有教練都有 `重訓` 專長
insert into "COACH_LINK_SKILL"(coach_id,skill_id)
select
	c.id,
	s.id
from "COACH" c
cross join
	(select * from "SKILL" where name = '重訓') s;
    -- 2. 教練`肌肉棒子` 需要有 `瑜伽` 專長
insert into "COACH_LINK_SKILL"(coach_id,skill_id)
values
	(
		(select c.id
			from "COACH" c
			inner join "USER" on "USER".id = c.user_id
			where c.user_id = (select id from "USER" u where "name" ='肌肉棒子')),
		(select id
			from "SKILL" s
			where name = '瑜伽')
	);
    -- 3. 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長
insert into "COACH_LINK_SKILL"(coach_id,skill_id)
values
	(
		(select c.id
			from "COACH" c
			inner join "USER" on "USER".id = c.user_id
			where c.user_id = (select id from "USER" u where "name" ='Q太郎')),
		(select id
			from "SKILL" s
			where name = '有氧運動')
	),
	(
		(select c.id
			from "COACH" c
			inner join "USER" on "USER".id = c.user_id
			where c.user_id = (select id from "USER" u where "name" ='Q太郎')),
		(select id
			from "SKILL" s
			where name = '復健訓練')
	);

-- 3-3 修改：更新教練的經驗年數，資料需求如下：
    -- 1. 教練`肌肉棒子` 的經驗年數為3年
update "COACH" 
set experience_years = 3
where user_id = (select id from "USER" where name = '肌肉棒子');
    -- 2. 教練`Q太郎` 的經驗年數為5年
update "COACH" 
set experience_years = 5
where user_id = (select id from "USER" where name = 'Q太郎');
-- 3-4 刪除：新增一個專長 空中瑜伽 至 SKILL 資料表，之後刪除此專長。
insert into "SKILL" ("name")
values('空中瑜伽');

delete from "SKILL" 
where name = '空中瑜伽';

--  ████████  █████   █    █   █ 
--    █ █   ██    █  █     █   █ 
--    █ █████ ███ ███      █████ 
--    █ █   █    ██  █         █ 
--    █ █   █████ █   █        █ 
-- ===================== ==================== 
-- 4. 課程管理 COURSE 、組合包方案 CREDIT_PACKAGE

-- 4-1. 新增：在`COURSE` 新增一門課程，資料需求如下：
    -- 1. 教練設定為用戶`李燕容` 
    -- 2. 在課程專長 `skill_id` 上設定為「 `重訓` 」
    -- 3. 在課程名稱上，設定為「`重訓基礎課`」
    -- 4. 授課開始時間`start_at`設定為2024-11-25 14:00:00
    -- 5. 授課結束時間`end_at`設定為2024-11-25 16:00:00
    -- 6. 最大授課人數`max_participants` 設定為10
    -- 7. 授課連結設定`meeting_url`為 https://test-meeting.test.io
insert into "COURSE"(user_id,skill_id,"name",start_at,end_at,max_participants,meeting_url)
values
	(
		(select id from "USER" where name = '李燕容'),
		(select id from "SKILL" where name = '重訓'),
		'重訓基礎課',
		'2024-11-25 14:00:00',
		'2024-11-25 16:00:00',
		10,
		'https://test-meeting.test.io'
	);

-- ████████  █████   █    █████ 
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █         █ 
--   █ █   █████ █   █    ████  
-- ===================== ====================

-- 5. 客戶預約與授課 COURSE_BOOKING
-- 5-1. 新增：請在 `COURSE_BOOKING` 新增兩筆資料：
    -- 1. 第一筆：`王小明`預約 `李燕容` 的課程
        -- 1. 預約人設為`王小明`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課
    -- 2. 新增： `好野人` 預約 `李燕容` 的課程
        -- 1. 預約人設為 `好野人`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課
insert into "COURSE_BOOKING" (user_id,course_id,booking_at,status)
values
	(
		(select id from "USER" where name = '王小明'),
		(select id from "COURSE" where user_id = (select id from "USER" where name = '李燕容')),
		'2024-11-24 16:00:00',
		'即將授課'
	),
	(
		(select id from "USER" where name = '好野人'),
		(select id from "COURSE" where user_id = (select id from "USER" where name = '李燕容')),
		'2024-11-24 16:00:00',
		'即將授課'
	);

-- 5-2. 修改：`王小明`取消預約 `李燕容` 的課程，請在`COURSE_BOOKING`更新該筆預約資料：
    -- 1. 取消預約時間`cancelled_at` 設為2024-11-24 17:00:00
    -- 2. 狀態`status` 設定為課程已取消
update "COURSE_BOOKING"
set
	cancelled_at = '2024-11-24 17:00:00',
	status = '課程已取消'
where 
	user_id = (select id from "USER" where name = '王小明')
	and course_id = (select id from "COURSE" where user_id = (select id from "USER" where name = '李燕容'));
	
-- 5-3. 新增：`王小明`再次預約 `李燕容`   的課程，請在`COURSE_BOOKING`新增一筆資料：
    -- 1. 預約人設為`王小明`
    -- 2. 預約時間`booking_at` 設為2024-11-24 17:10:25
    -- 3. 狀態`status` 設定為即將授課
insert into "COURSE_BOOKING"(user_id,course_id,booking_at,status)
values
	(
		(select id from "USER" where name = '王小明'),
		(select id from "COURSE" where user_id = (select id from "USER" where name = '李燕容')),
		'2024-11-24 17:10:25',
		'即將授課'
	);

-- 5-4. 查詢：取得王小明所有的預約紀錄，包含取消預約的紀錄
select * from "COURSE_BOOKING"
where user_id = (select id from "USER" where name = '王小明');

-- 5-5. 修改：`王小明` 現在已經加入直播室了，請在`COURSE_BOOKING`更新該筆預約資料（請注意，不要更新到已經取消的紀錄）：
    -- 1. 請在該筆預約記錄他的加入直播室時間 `join_at` 設為2024-11-25 14:01:59
    -- 2. 狀態`status` 設定為上課中
update "COURSE_BOOKING"
set join_at = '2024-11-25 14:01:59', status= '上課中' 
where user_id = (select id from "USER" where name = '王小明') 
	and course_id = (select id from "COURSE" where user_id = (select id from "USER" where name = '李燕容')) 
	and status = '即將授課';
	
-- 5-6. 查詢：計算用戶王小明的購買堂數，顯示須包含以下欄位： user_id , total。 (需使用到 SUM 函式與 Group By)
select
	cp.user_id,
	sum(cp.purchased_credits) as total
from "CREDIT_PURCHASE" cp
where cp.user_id = (select id from "USER" where name = '王小明')
group by cp.user_id;

-- 5-7. 查詢：計算用戶王小明的已使用堂數，顯示須包含以下欄位： user_id , total。 (需使用到 Count 函式與 Group By)
select
	cb.user_id, 
	count(*) as total
from "COURSE_BOOKING" cb
where cb.user_id = (select id from "USER" where name = '王小明')
    and status in ('上課中')
group by cb.user_id;

-- 5-8. [挑戰題] 查詢：請在一次查詢中，計算用戶王小明的剩餘可用堂數，顯示須包含以下欄位： user_id , remaining_credit
    -- 提示：
    -- select ("CREDIT_PURCHASE".total_credit - "COURSE_BOOKING".used_credit) as remaining_credit, ...
    -- from ( 用戶王小明的購買堂數 ) as "CREDIT_PURCHASE"
    -- inner join ( 用戶王小明的已使用堂數) as "COURSE_BOOKING"
    -- on "COURSE_BOOKING".user_id = "CREDIT_PURCHASE".user_id;

/*
王小明的購買堂數是：14 + 21 = 35
王小明的以使用堂數是：只有1堂狀態是上課中，所以是1堂
所以最後算出來剩餘可用堂數是：35 - 1 = 34
*/

-- 267行到276行指令有算出 34
select
	cp.user_id as user_id,
	sum(cp.purchased_credits) - (select count(*)
									from "COURSE_BOOKING" cb
									inner join "USER" u on u.id = cb.user_id 
									where u."name" = '王小明' and status = '上課中') as remaining_credit
from "CREDIT_PURCHASE" cp 
inner join "USER" u on u.id = cp.user_id 
where u."name" = '王小明'
group by cp.user_id;

-- 偏提示的做法，但算出來是33 不曉得為什麼 count(cbuser.user_id) 這邊是算出是 2，所以 35 - 2 = 33 是錯的
-- 單獨下指令 289行到291行 算出 35
select sum(cp.purchased_credits) from "CREDIT_PURCHASE" cp 
inner join "USER" u on u.id = cp.user_id 
where u."name" = '王小明';

-- 單獨下指令 294行到296行 算出 1
select count(*) from "COURSE_BOOKING" cb
inner join "USER" u on u.id = cb.user_id 
where u."name" = '王小明' and status = '上課中';

-- 照提示做，但放在一起算出來變成 35 - 2
select sum(cpuser.purchased_credits) - count(cbuser.user_id) from 
	(select * from "CREDIT_PURCHASE" cp 
		inner join "USER" u on u.id = cp.user_id 
		where u."name" = '王小明') cpuser 
inner join (select * from "COURSE_BOOKING" cb
				inner join "USER" u on u.id = cb.user_id 
				where u."name" = '王小明' and status = '上課中') cbuser 
		on cbuser.user_id = cpuser.user_id;

-- 12/6 先在子查詢裡面算完，不要用 join 後的表做運算，成功算出 35 - 1 = 34 筆
select
	cpuser.user_id as user_id,
	(cpuser.total_credit - cbuser.used_credit) as remaining_credit
from 
	(select 
		cp.user_id,
		sum(cp.purchased_credits) as total_credit
	from "CREDIT_PURCHASE" cp 
	inner join "USER" u on u.id = cp.user_id 
	where u."name" = '王小明'
	group by cp.user_id) cpuser 
inner join (select
				cb.user_id,
				count(*) as used_credit
			from "COURSE_BOOKING" cb
			inner join "USER" u on u.id = cb.user_id 
			where u."name" = '王小明' and status = '上課中'
			group by cb.user_id) cbuser 
	on cbuser.user_id = cpuser.user_id;

-- ████████  █████   █     ███  
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █     █   █ 
--   █ █   █████ █   █     ███  
-- ===================== ====================
-- 6. 後台報表
-- 6-1 查詢：查詢專長為重訓的教練，並按經驗年數排序，由資深到資淺（需使用 inner join 與 order by 語法)
-- 顯示須包含以下欄位： 教練名稱 , 經驗年數, 專長名稱
select 
	u."name" as 教練名稱,
	c.experience_years as 經驗年數,
	s."name" as 專長名稱
from "COACH_LINK_SKILL" cls 
inner join "SKILL" s on s.id = cls.skill_id
inner join "COACH" c on c.id = cls.coach_id
inner join "USER" u on u.id = c.user_id 
where s."name" = '重訓'
order by c.experience_years desc;

-- 6-2 查詢：查詢每種專長的教練數量，並只列出教練數量最多的專長（需使用 group by, inner join 與 order by 與 limit 語法）
-- 顯示須包含以下欄位： 專長名稱, coach_total
select
	s.name as 專長名稱,
	count(*) as coach_total
from "COACH_LINK_SKILL" cls 
inner join "SKILL" s on cls.skill_id = s.id
group by s.name
order by coach_total desc 
limit 1;

-- 6-3. 查詢：計算 11 月份組合包方案的銷售數量
-- 顯示須包含以下欄位： 組合包方案名稱, 銷售數量
select
	cp."name" as 組合包方案名稱,
	count(*) as 銷售數量
from "CREDIT_PURCHASE" cp2 
inner join "CREDIT_PACKAGE" cp on cp.id = cp2.credit_package_id
group by cp."name";

-- 6-4. 查詢：計算 11 月份總營收（使用 purchase_at 欄位統計）
-- 顯示須包含以下欄位： 總營收
select sum(price_paid) as 總營收
from "CREDIT_PURCHASE"
where purchase_at between '2024-11-01 00:00:00' and '2024-11-30 23:59:59';

-- 6-5. 查詢：計算 11 月份有預約課程的會員人數（需使用 Distinct，並用 created_at 和 status 欄位統計）
-- 顯示須包含以下欄位： 預約會員人數
select count(distinct(user_id)) as 預約會員人數 from "COURSE_BOOKING" cb 
where created_at between '2024-11-01 00:00:00' and '2024-11-30 23:59:59' and status != '課程已取消';