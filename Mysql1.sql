CREATE TABLE student (
 id INT, -- 编号
 NAME VARCHAR(20), -- 姓名
 age INT, -- 年龄
 sex VARCHAR(5), -- 性别
 address VARCHAR(100), -- 地址
 math INT, -- 数学
 english INT -- 英语
);
INSERT INTO student(id,NAME,age,sex,address,math,english) VALUES (1,'马云',55,'男','
杭州',66,78),(2,'马化腾',45,'女','深圳',98,87),(3,'马景涛',55,'男','香港',56,77),(4,'柳岩
',20,'女','湖南',76,65),(5,'柳青',20,'男','湖南',86,NULL),(6,'刘德华',57,'男','香港',99,99),(7,'马德',22,'女','香港',99,99),(8,'德玛西亚',18,'男','南京',56,65);

DROP TABLE student;

SELECT * FROM student;

-- 查询 姓名 和 年龄
SELECT 
	NAME, -- 姓名
	age   -- 年龄
FROM 
	student;


SELECT address FROM student;

-- 去除重复的结果集 distinct
SELECT	DISTINCT address FROM student;


-- 计算 math 和 english 分数之和

SELECT NAME,math,english,math+english FROM student;
-- 如果有null参与的运算，计算结果都为null

SELECT NAME,math,english,math + IFNULL(english, 0) FROM student;

-- 起别名

SELECT NAME,math,english,math + IFNULL(english, 0) AS 总分 FROM student;

SELECT NAME 姓名,math 数学,english 英语,math + IFNULL(english, 0) AS 总分 FROM student;



-- 查询年龄大于20岁
SELECT * FROM student WHERE age > 20;

-- 查询年龄大于等于20岁
SELECT * FROM student WHERE age >=20;

-- 查询年龄等于20岁
SELECT * FROM student WHERE age = 20;

-- 查询年龄不等于20岁
SELECT * FROM student WHERE age != 20;
SELECT * FROM student WHERE age <> 20;

-- 查询年龄大于等于20 小于等于30
SELECT * FROM student WHERE age >= 20 && age <= 30; -- 不推荐
SELECT * FROM student WHERE age >= 20 AND age <= 30;
SELECT * FROM student WHERE age BETWEEN 20 AND 30;

-- 查询年龄22岁，18岁，25岁的信息
SELECT * FROM student WHERE age = 22 OR age = 18 OR age = 25;
SELECT * FROM student WHERE age IN (22,18,25);

SELECT * FROM student;

-- 查询英语成绩为null
SELECT * FROM student WHERE english IS NULL;

-- 查询英语成绩不为null
SELECT * FROM student WHERE english IS NOT NULL;



-- 模糊查询

-- 查询姓马的有哪些？
SELECT * FROM student WHERE NAME LIKE '马%';

-- 查询第二个字是化的人
SELECT * FROM student WHERE NAME LIKE "_化%";

-- 查询姓名是三个字的人
SELECT * FROM student WHERE NAME LIKE '___';

-- 查询姓名中包含德的人
SELECT * FROM student WHERE NAME LIKE '%德%';



-- 排序查询
SELECT * FROM student ORDER BY math; -- 默认升序 ASC

SELECT * FROM student ORDER BY math DESC; -- 降序

-- 按照数学成绩排名，如果数学成绩一样则按照英语成绩排名
SELECT * FROM student ORDER BY math ASC, english ASC; 
-- 如果有多个排序条件，当前边的条件相同时才会判断第二条件




-- 聚合函数：
-- 将一列数据作为一个整体，进行纵向的计算
-- 1. count:计算个数
-- 2. max：计算最大值
-- 3. min：计算最小值
-- 4. sun：计算和
-- 5. avg：计算平均


SELECT COUNT(NAME) FROM student;
-- 聚合函数的计算，排除null值, 选择不包含非空的列计算（主键）；IFNULL函数
SELECT COUNT(english) FROM student;

SELECT COUNT(IFNULL(english,0)) FROM student;

SELECT COUNT(*) FROM student;

SELECT MAX(math) FROM student;

SELECT MIN(math) FROM student;

SELECT SUM(english) FROM student;

SELECT AVG(math)数学平均分 FROM student;


SELECT * FROM student;
-- 分组查询
-- 1. 语法：group by+分组字段
-- 2. 注意：（1）分组之后查询的字段：分组字段，聚合函数
--          （2）where 和 having 的区别是？
--               1. where 在分组之前进行限定，如果不满足条件，则不参与分组。
--                  having 在分组之后进行限定，如果不满足结果，则不会被查询出来
--               2. where 后不可以跟聚合函数，having可以进行聚合函数的判断


-- 按性别分组，分别查询男女同学的平均分
SELECT sex, AVG(math) FROM student GROUP BY sex;

-- 按性别分组，分别查询男女同学的平均分,人数
SELECT sex 性别, AVG(math) 平均分,COUNT(id) 人数 FROM student GROUP BY sex;

-- 按性别分组，分别查询男女同学的平均分,人数 要求：分数低于70分的不参与分组
SELECT sex 性别, AVG(math) 平均分,COUNT(id) 人数 FROM student WHERE math > 70 GROUP BY sex;

-- 按性别分组，分别查询男女同学的平均分,人数 要求：分数低于70分的不参与分组;分组之后人数大于2个人
SELECT sex 性别, AVG(math) 平均分,COUNT(id) 人数 FROM student WHERE math > 70 GROUP BY sex HAVING COUNT(id) > 2;



-- 分页查询
--   1. 语法：limit 开始的索引，每页查询的页数


-- 每页显示三条记录
SELECT * FROM student LIMIT 0,3; -- 第一页

SELECT * FROM student LIMIT 3,3; -- 第二页

SELECT * FROM student LIMIT 6,3; -- 第三页

-- 公式：开始的索引 = （当前的页码 - 1）* 每页显示的条数 




-- 约束
-- 概念：对表中的数据进行限定，保证数据的正确性，有效性和完整性
-- 分类：
--     1. 主键约束：primary key
--     2. 非空约束：nut null
--     3. 唯一约束：unique
--     4. 外键约束：foreign key


-- 非空约束
-- 1. 创建表时添加约束
-- 2. 创建表后添加约束
CREATE TABLE stu (
	id INT,
	NAME VARCHAR(20) NOT NULL -- 为非空
);
-- 删除name的非空约束
ALTER TABLE stu MODIFY NAME VARCHAR(20);
-- 添加name的非空约束
ALTER TABLE stu MODIFY NAME VARCHAR(20) NOT NULL;


-- 唯一约束：unique 某一列的值不能重复
-- 注意：唯一约束可以有null值，但是只能有一条记录为null
CREATE TABLE stu(
	id INT,
	phone_number VARCHAR(20) UNIQUE -- 手机号
);
-- 删除唯一约束
ALTER TABLE stu DROP INDEX phone_number;
-- 在表创建后添加唯一约束
ALTER TABLE stu phone_number VARCHAR(20) UNIQUE;

-- 主键约束：primary key
-- 含义：非空且唯一，
--       一张表只能有一个主键
--       主键就是表中记录的唯一标识
CREATE TABLE stu(
	id INT PRIMARY KEY , -- 给id添加主键约束
	NAME VARCHAR(20)
);
-- 删除主键
ALTER TABLE stu DROP PRIMARY KEY;
-- 创建表后添加主键
ALTER TABLE stu MODIFY id INT PRIMARY KEY;

-- 主键约束--自动增长 
-- 概念：如果某一列时数值类型的，使用 auto_increment 可以来完成自动增长
CREATE TABLE stu(
	id INT PRIMARY KEY AUTO_INCREMENT, -- 给id添加主键约束
	NAME VARCHAR(20)
);

SELECT * FROM stu;

INSERT INTO stu VALUES(NULL,'ccc');
-- 删除自动增长
ALTER TABLE stu MODIFY id INT;
-- 添加自动增长
ALTER TABLE stu MODIFY id INT AUTO_INCREMENT;


-- 外键约束, foreign key 
-- 让表与表产生关系，从而保证数据的正确性
-- 1. 在创建表时，可以添加外键约束

CREATE TABLE emp ( -- 创建emp类
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(30),
age INT,  
dep_name VARCHAR(30), -- 部门名称
dep_location VARCHAR(30)  -- 部门地址
);
-- 添加数据
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('张三', 20, '研发部', '广州');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('李四', 21, '研发部', '广州');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('王五', 20, '研发部', '广州');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('老王', 20, '销售部', '深圳');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('大王', 22, '销售部', '深圳');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('小王', 18, '销售部', '深圳');

SELECT * FROM emp;
-- 数据又冗余


-- 解决方案：分成 2 张表
-- 创建部门表(id,dep_name,dep_location)
-- 一方，主表
CREATE TABLE department(
	id INT PRIMARY KEY AUTO_INCREMENT,
	dep_name VARCHAR(20),
	dep_location VARCHAR(20)
);
-- 创建员工表(id,name,age,dep_id)
-- 多方，从表
CREATE TABLE employee(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20),
	age INT,
	dep_id INT ,-- 外键对应主表的主键
	CONSTRAINT emp_dept_fk FOREIGN KEY (dep_id) REFERENCES department(id)
);
-- 添加 2 个部门
INSERT INTO department VALUES(NULL, '研发部','广州'),(NULL, '销售部', '深圳');

-- 添加员工,dep_id 表示员工所在的部门
INSERT INTO employee (NAME, age, dep_id) VALUES ('张三', 20, 1);
INSERT INTO employee (NAME, age, dep_id) VALUES ('李四', 21, 1);
INSERT INTO employee (NAME, age, dep_id) VALUES ('王五', 20, 1);
INSERT INTO employee (NAME, age, dep_id) VALUES ('老王', 20, 2);
INSERT INTO employee (NAME, age, dep_id) VALUES ('大王', 22, 2);
INSERT INTO employee (NAME, age, dep_id) VALUES ('小王', 18, 2);

SELECT * FROM employee;

SELECT * FROM department;

-- 删除外键约束
ALTER TABLE employee DROP FOREIGN KEY emp_dept_fk;

-- 创建表后添加外键约束
ALTER TABLE employee ADD CONSTRAINT emp_dept_fk FOREIGN KEY (dep_id) REFERENCES department(id);


-- 通常操作，操作麻烦
UPDATE employee SET dep_id = NULL WHERE dep_id = 1;

UPDATE employee SET dep_id = 5 WHERE dep_id IS NULL;

SELECT * FROM employee;

SELECT * FROM department;



-- 外键约束---级联操作

-- 删除外键约束
ALTER TABLE employee DROP FOREIGN KEY emp_dept_fk;

-- 添加外键， 设置级联更新,级联删除
-- 级联删除：ON DELETE CASCADE
-- 级联更新：ON UPDATE CASCADE
ALTER TABLE employee ADD CONSTRAINT emp_dept_fk FOREIGN KEY (dep_id) REFERENCES department(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- 数据库的设计
--      1. 多表之间的关系
--         （1）一对一：如 人和身份证
--         （2）一对多（多对一）：如 部门和员工，分析：一个部门有多个员工，一个员工只能对应一个部门
--         （3）多对多：如 学生和课程，分析：一个学生可以选多门课程，一个课程也可以被很多学生选择
                 
--      2. 数据库设计的范式


-- 多表关系案例

-- 创建旅游线路分类表 tab_category
-- cid 旅游线路分类主键，自动增长
-- cname 旅游线路分类名称非空，唯一，字符串 100
CREATE TABLE tab_category (
	 cid INT PRIMARY KEY AUTO_INCREMENT,
	 cname VARCHAR(100) NOT NULL UNIQUE
);
-- 添加旅游线路分类数据：
INSERT INTO tab_category (cname) VALUES ('周边游'), ('出境游'), ('国内游'), ('港澳游');

SELECT * FROM tab_category;

-- 创建旅游线路表 tab_route
/*
rid 旅游线路主键，自动增长
rname 旅游线路名称非空，唯一，字符串 100
price 价格
rdate 上架时间，日期类型
cid 外键，所属分类
*/
CREATE TABLE tab_route(
	 rid INT PRIMARY KEY AUTO_INCREMENT,
	 rname VARCHAR(100) NOT NULL UNIQUE,
	 price DOUBLE,
	 rdate DATE,
	 cid INT,
	 FOREIGN KEY (cid) REFERENCES tab_category(cid)
);
-- 添加旅游线路数据
INSERT INTO tab_route VALUES
(NULL, '【厦门+鼓浪屿+南普陀寺+曾厝垵 高铁 3 天 惠贵团】尝味友鸭面线 住 1 晚鼓浪屿', 1499,
'2018-01-27', 1),
(NULL, '【浪漫桂林 阳朔西街高铁 3 天纯玩 高级团】城徽象鼻山 兴坪漓江 西山公园', 699, '2018-02-
22', 3),
(NULL, '【爆款￥1699 秒杀】泰国 曼谷 芭堤雅 金沙岛 杜拉拉水上市场 双飞六天【含送签费 泰风情 广州
往返 特价团】', 1699, '2018-01-27', 2),
23 / 26
(NULL, '【经典•狮航 ￥2399 秒杀】巴厘岛双飞五天 抵玩【广州往返 特价团】', 2399, '2017-12-23',
2),
(NULL, '香港迪士尼乐园自由行 2 天【永东跨境巴士广东至迪士尼去程交通+迪士尼一日门票+香港如心海景酒店
暨会议中心标准房 1 晚住宿】', 799, '2018-04-10', 4);

SELECT * FROM tab_route;

/*创建用户表 tab_user
uid 用户主键，自增长
username 用户名长度 100，唯一，非空
password 密码长度 30，非空
name 真实姓名长度 100
birthday 生日
sex 性别，定长字符串 1
telephone 手机号，字符串 11
email 邮箱，字符串长度 100
*/
CREATE TABLE tab_user (
	 uid INT PRIMARY KEY AUTO_INCREMENT,
	 username VARCHAR(100) UNIQUE NOT NULL,
	 PASSWORD VARCHAR(30) NOT NULL,
	 NAME VARCHAR(100),
	 birthday DATE,
	 sex CHAR(1) DEFAULT '男',
	 telephone VARCHAR(11),
	 email VARCHAR(100)
);

-- 添加用户数据
INSERT INTO tab_user VALUES
(NULL, 'cz110', 123456, '老王', '1977-07-07', '男', '13888888888', '66666@qq.com'),
(NULL, 'cz119', 654321, '小王', '1999-09-09', '男', '13999999999', '99999@qq.com');

SELECT * FROM tab_user;


/*
创建收藏表 tab_favorite
rid 旅游线路 id，外键
date 收藏时间
uid 用户 id，外键
rid 和 uid 不能重复，设置复合主键，同一个用户不能收藏同一个线路两次
*/
CREATE TABLE tab_favorite (
 rid INT,
 DATE DATETIME,
 uid INT,
 -- 创建复合主键
 PRIMARY KEY(rid,uid),  -- 联合主键
 FOREIGN KEY (rid) REFERENCES tab_route(rid),
 FOREIGN KEY(uid) REFERENCES tab_user(uid)
)

-- 增加收藏表数据
INSERT INTO tab_favorite VALUES
25 / 26
(1, '2018-01-01', 1), -- 老王选择厦门
(2, '2018-02-11', 1), -- 老王选择桂林
(3, '2018-03-21', 1), -- 老王选择泰国
(2, '2018-04-21', 2), -- 小王选择桂林
(3, '2018-05-08', 2), -- 小王选择泰国
(5, '2018-06-02', 2); -- 小王选择迪士尼

SELECT * FROM tab_favorite;



-- 数据库设计的范式
/*设计关系数据库时，遵从不同的规范要求，
  设计出合理的关系型数据库，这些不同的规范要求被称为不同的范式，
  各种范式呈递次规范，越高的范式数据库冗余越小。
  目前关系数据库有六种范式：第一范式（1NF）、第二范式（2NF）、第三范式（3NF）、
  巴斯-科德范式（BCNF）、第四范式(4NF）和第五范式（5NF，又称完美范式）。
*/ 
-- 分类
/* 1. 第一范式（1NF）：每一列都是不可分割的原子数据项
   2. 第二范式（2NF）：在1NF的基础上，非码属性必须完全依赖于候选码
      （在1NF基础上消除非主属性对主码的部分函数依赖）
      几个概念
      （1）函数依赖：A-->B，通过A属性的值，可以唯一确定B属性的值，则称B依赖于A
      如，学号-->姓名，（学号，课程名）-->分数
      
      （2）完全函数依赖：A-->B，如果A是一个属性组，则B属性值的确定需要依赖于A属性组中所有的属性值
      如，（学号，课程名）-->分数
      
       (3)部分函数依赖：A-->B，如果A时一个属性组，则B属性值的确定只需要A属性组中某一些值即可
       如，（学号，课程名）-->姓名       
       
      （4）传递函数依赖：A-->B，B-->C,则 A-->C;如果通过A属性（属性组）的值，可以唯一确定B的值，
                         在通过B属性（属性组）的值可以唯一确定C属性的值，则称C传递依赖于A
       如，学号-->系名，系名-->系主任  
       
      （5）码如果在一张表中，一个属性或属性组被其他所有属性所完全依赖，则称这个属性（属性组）为该表的码
       如，该表中码为：（学号，课程名称）
      
   3. 第三范式（3NF）：在2NF的基础上，任何非主属性不依赖于其他非主属性
      （在2NF的基础上消除传递依赖）
*/


-- 数据库的备份和还原
/*
   1. 命令行：
      语法：
         备份： mysqldump -u用户名 -p密码 > 保存路径
         还原
 
*/




