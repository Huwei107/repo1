-- 事务
/*
	1.概念：
	    如果一个包含多个步骤的业务操作，被事务管理，那么这些操作要么同时成功，要么同时失败
	2.操作： 
	    1.开启事务：start transaction
	    2.回滚:     rollback
	    3.提交 :	commit
	3.事务的四大特征
*/

-- 创建数据表
CREATE TABLE account (
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(10),
balance DOUBLE
);
-- 添加数据
INSERT INTO account (NAME, balance) VALUES ('张三', 1000), ('李四', 1000);

SELECT * FROM account;
UPDATE account SET balance = 1000;

-- 张三给李四转账500元

-- 开启事务
START TRANSACTION;

-- 1. 张三账户 -500
UPDATE account SET balance = balance - 500 WHERE NAME = '张三';
-- 2. 李四账户 +500
-- 出错了。。。
UPDATE account SET balance = balance + 500 WHERE NAME = '李四';

-- 提交事务
COMMIT;

-- 回滚事务
ROLLBACK;


/*
	事务提交的两种方式（mysql默认为自动提交）
	    * 自动提交
	          mysql就是自动提交的
	          一条DML（增删改）语句会自动提交一次事务
	    * 手动提交
		  Oracle默认是手动提交
	          需要先开启事务，再提交
	修改事务的默认提交方式
	    * 查看事务的默认提交方式：SELECT @@autocommot; -- 1代表自动提交 
							   -- 0代表手动提交
	    * 修改默认提交方式：set @@autocommit = 0;
*/

/*
	事务的四大特征
		1. 原子性：是不可分割的最小操作单位，要么同时成功，要么同时失败
		2. 持久性：当事务提交或回滚后，数据库会持久化的保存数据
		3. 隔离性：多个事务之间 相互独立
		4. 一致性：事务操作前后数据总量不变
*/

/*
	事务的隔离级别
		概念：多个事务之间是隔离的，相互独立的。但是如果多个事务操作同一批数据，则会引发一些问题，设置不同的隔离级别就可以解决问题
		存在问题：
		    1.脏读：一个事务，读取到另一事务中没有提交的数据
		    2.不可重复读（虚读）：不在同一个事务中， 两次读取到的数据不一样
		    3.幻读：一个事务操作（DML）数据表中所有记录，另一个事务添加了一条数据，则第一个查询不到自己的修改
		隔离级别：
		    1. read uncommi--读未提交
		        产生的问题：脏读/不可重复读/幻读
		    2. read commit--读已提交（Oracle默认）
		        产生的问题：不可重复读/幻读
		    3. repeatable read--可重复读（MySQL默认）
		        产生的问题：幻读
		    4. serializable--串行化
		        可以解决所有问题
		注：隔离级别从小到大安全性越来越高，但是效率越来越低
		
		数据库查询隔离级别：select @@tx_isolation;
		数据库设置隔离级别：set global transaction isolation level 级别字符串;
*/

/*
	SQL分类：
	   1. DDL：操作数据库和表
	   2. DML：增删改表中的数据
	   3. DQL：查询表中的数据
	   4. DCL：管理用户，授权
*/

/*
	  DCL：查询用户，授权
	     1. 添加用户：
	          语法：CREATE USER '用户名'@‘主机名’ IDENTIFIED BY '密码';
	     2. 删除用户：
	          语法：DROP USER '用户名'@'主机名';
	     3. 修改用户密码：
	          语法： 1. UPDATE USER SET PASSWORD = PASSWORD('新密码') WHERE USER = '用户名';
	                 2. SET PASSWORD FOR '用户名'@‘主机名’ = PASSWORD('新密码');
	     4. 查询用户：
	          -- 1.切换到mysql数据库
	               USE mysql
	          -- 2.查询user表
	               SELECT * FROM USER
	               
	     5. 授权
	        1. 查询权限：SHOW GRANTS FOR '用户名'@‘主机名’;
	        2. 授予权限：GRANT 权限列表 ON 数据库名.表名 TO '用户名'@'主机名';
	        3. 撤销权限：REVOKE 权限列表 ON 数据库名.表名 FROM '用户名'@‘主机名’;
*/








