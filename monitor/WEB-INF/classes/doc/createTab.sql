CREATE DATABASE nanji_db DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE monitor_db DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


create table download_info(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	file_name varchar(200)  COMMENT '文件名',
	product_time varchar(500) COMMENT '生成时间',
	user_id varchar(20) COMMENT '用户',
	suc_flag varchar(2) COMMENT '成功标识'	
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

alter table download_info add suc_flag varchar(2)  COMMENT '成功标识';

create table  net_info(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	href varchar(200) DEFAULT NULL COMMENT '网址地址',
	emp_name varchar(500) DEFAULT NULL COMMENT '企业名称',
	emp_emai varchar(20) DEFAULT NULL COMMENT '企业邮箱',
	create_time varchar(20) COMMENT '创建时间',
	cls varchar(100)  COMMENT '归类'，
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--alter table net_info add cls varchar(100)  COMMENT '归类';
--alter table net_info drop column class ; 

drop table net_info_monitor;
create table  net_info_monitor(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	href varchar(200) DEFAULT NULL COMMENT '网址地址',
	emp_name varchar(500) DEFAULT NULL COMMENT '企业名称',
	emp_emai varchar(20) DEFAULT NULL COMMENT '企业邮箱',
	num int(6)  DEFAULT NULL COMMENT '错误码',
	flag varchar(1)  COMMENT '邮件标识',
	err_num int(2) COMMENT '连续出错次数',
	create_time varchar(20) COMMENT '创建时间',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;


create table  net_info_mail(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	href varchar(200) DEFAULT NULL COMMENT '网址地址',
	emp_name varchar(500) DEFAULT NULL COMMENT '企业名称',
	emp_emai varchar(20) DEFAULT NULL COMMENT '企业邮箱',
	err_code varchar(4)  DEFAULT NULL COMMENT '错误码',
	err_msg varchar(50) COMMENT '错误消息',
	send_time varchar(14) COMMENT '发送时间',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;



ALTER TABLE net_info ADD INDEX herf_indx (href);

insert into net_info (href,num) values ('wwww.qq.com',200);


--菜单表
create table net_menu(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	menu_id int(6) NOT NULL COMMENT  '菜单编码',
	menu_name varchar(100) not null COMMENT '菜单名称', 
	parent_id int(6) NOT NULL COMMENT  '父级菜单编码',
	parent_name varchar(100) not null COMMENT '父级菜单名称',
	url varchar(100) not null COMMENT '菜单地址',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;
ALTER TABLE net_menu ADD INDEX  menu_indx (menu_id);



drop table net_user;
create table net_user(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	user_id varchar(30) NOT NULL  COMMENT '用户名',
	dep_id int(10) NOT NULL  COMMENT '部门',
	role_id int(10) NOT NULL  COMMENT '角色',
	dep_name varchar(30) NOT NULL  COMMENT '部门名称',
	role_name varchar(30) NOT NULL  COMMENT '角色名称',
	user_name varchar(60) COMMENT '用户名',
	user_email varchar(60) COMMENT '用户邮箱',
	user_mobile varchar(11) COMMENT '用户手机号码',
	user_qq varchar(12) COMMENT '用户QQ',
	user_wechat varchar(60) COMMENT '用户微信',
	user_login_time varchar(20) COMMENT '用户登陆时间',
	user_login_number int COMMENT '用户登陆次数',
	user_createtime varchar(20) COMMENT '创建用户时间',
	password  varchar(36) not null COMMENT '用户手机号码',
	user_frozen  varchar(10)  COMMENT '用户冻结标识',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;


alter table net_user modify column user_frozen varchar(10) COMMENT '用户冻结标识';
ALTER TABLE net_user ADD unique user_id_idx (user_id);

drop table net_dept
create table net_dept(
	dep_id int(10) NOT NULL  COMMENT '部门',
	role_id int(10) NOT NULL  COMMENT '角色',
	user_id varchar(30) NOT NULL  COMMENT '用户名',
	dep_name varchar(100) NOT NULL  COMMENT '部门名称',
	role_name varchar(100) NOT NULL  COMMENT '角色名称',
	primary key(dep_id,role_id)
);

ADD UNIQUE KEY(resource_name, resource_type); 

create table net_func(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	dep varchar(30) NOT NULL  COMMENT '部门',
	role varchar(30) NOT NULL COMMENT '角色',
	user_id varchar(30) COMMENT '用户ID',
	menu_id varchar(256) NOT NULL COMMENT  '菜单编码',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

ALTER TABLE net_func add column user_id varchar(30);

drop table net_word
create table net_word(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	key_word varchar(30) NOT NULL  COMMENT '关键词',
	user_money double(20,5)  COMMENT '用户金额',
	proxy_money double(20,5)  COMMENT '代理金额',
	net_address varchar(200) NULL  COMMENT '网址',
	word_team varchar(200)   COMMENT '分组',
	word_engin varchar(200)   COMMENT '引擎',
	word_order varchar(20)   COMMENT '排名',
	target_order varchar(20)   COMMENT '目标排名',
	original_order varchar(10)  COMMENT '原排名',
	word_custmer varchar(200) NOT NULL  COMMENT '客户',
	create_time varchar(20) NOT NULL  COMMENT '创建时间',
	comfirm_time varchar(20) NOT NULL  COMMENT '确认时间',
	flag varchar(60) NOT NULL  COMMENT '单词标识',
	dep_id int(10) NOT NULL  COMMENT '部门',
	role_id int(10) NOT NULL  COMMENT '角色',
	word_flag varchar(2) COMMENT '扣费标识',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table net_word_hostory(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	key_word varchar(30) NOT NULL  COMMENT '关键词',
	net_address varchar(200) NULL  COMMENT '网址',
	word_order  varchar(20) NULL  COMMENT '当前关键词排名',
	uper_order  varchar(20) NULL  COMMENT '上一次关键词排名',
	cur_fee  varchar(20) NULL  COMMENT '本次扣费',
	rach_order varchar(10) NULL  COMMENT '是否达到排名',
	order_time varchar(20) NULL  COMMENT '排名时间',
	dep_id int(10) NOT NULL  COMMENT '部门',
	role_id int(10) NOT NULL  COMMENT '角色',
	word_custmer varchar(200) NOT NULL  COMMENT '客户',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;



alter table net_word add column word_flag varchar(2) COMMENT '扣费标识'


--财务表
create table net_finance_rechrage(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	money_amonut  double(20,5)  COMMENT '充值金额',
	amonut_time varchar(20)   COMMENT '充值日期',
	money_balance double(20,5) NOT NULL COMMENT '余额',
	money_coupon  double(20,5) COMMENT '优惠券',
	balance_time varchar(20)  NOT NULL COMMENT '余额更新时间',
	money_debit varchar(200)  COMMENT '扣费金额',
	debit_time varchar(20)  COMMENT '扣费时间',
	debit_reason varchar(200) COMMENT '扣费原因',
	debit_wordId varchar(20) COMMENT '扣费单词ID',
	user_id varchar(30) NOT NULL  COMMENT '用户ID',
	dep_id int(10) NOT NULL  COMMENT '部门ID',
	role_id int(10) NOT NULL  COMMENT '角色Id', 
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;





alter table net_finance modify column money_coupon  double(20,5)  COMMENT '优惠券';
alter table net_finance modify column money_coupon_flag  varchar(2)  COMMENT '是否扣的优惠券';
alter table net_finance add 
--更新列为空
alter table net_finance modify column money_amonut double(20,5);

alter table net_finance modify column amonut_time varchar(20);





alter table net_word add column target_order varchar(200) COMMENT '目标排名'
--original_order varchar(10)  COMMENT '原排名',
alter table net_word add column original_order varchar(10) COMMENT '原排名'

create table net_word_team
(
	id int(255) NOT NULL AUTO_INCREMENT primary key COMMENT '主键id',
	word_team varchar(200)   COMMENT '分组',
	word_custmer varchar(200) NOT NULL  COMMENT '客户',
	create_time varchar(200) NOT NULL  COMMENT '创建时间'
)
ALTER TABLE net_word_team ADD unique net_team_indx (word_team);
ALTER TABLE net_word_team ADD index   net_team_id (word_custmer);

--增加唯一索引,词分组，
ALTER TABLE net_word ADD unique net_word_indx (key_word,net_address);
alter table net_word add column flag varchar(1) not null;

alter table net_word add column comfirm_time varchar(20) not null;

--alter table net_word drop column comfirm_flag;

alter table net_word add dep_id  int(10) NOT NULL;
alter table net_word add role_id  int(10) NOT NULL;


--修改列允许为空
alter table net_word modify column flag varchar(60);
alter table  net_word modify column net_address varchar(200) null

create table net_word_user(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	key_id int(10) NOT NULL  COMMENT '关键词id',
	user_id varchar(30) NOT NULL  COMMENT '用户名',
	if_use varchar(3) NOT NULL  COMMENT '是否启用',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table net_flow(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	flow_id int(10) NOT NULL COMMENT '流程id', 
	flow_name varchar(30) COMMENT '流程net_dept;名称',
	checker_user varchar(30) COMMENT '审批人',
	nex_checker_user varchar(30) COMMENT '下一级审批人',
	node int(1)  not null COMMENT '当前节点',
	max_node int(1) not null COMMENT '最大节点',
	every_key int(10) not null COMMENT '业务主键',
	tab_name varchar(50) not null COMMENT '表名',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

ALTER TABLE net_flow ADD unique  menu_indx (flow_id);

create table net_flowing(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	every_key int(10) not null COMMENT '业务主键',
	tab_name varchar(50) not null COMMENT '表名',
	flow_id int(10) NOT NULL COMMENT '流程id', 
	agree varchar(3) NOT NULL COMMENT '是否同意', 
	node int(1)  not null COMMENT '当前节点',
--	next_node int(1)  not null COMMENT '下一节点',
	complete varchar(3)  not null  COMMENT '是否结束',
	user_id varchar(3)  not null  COMMENT '审批人',
	agree_time varchar(14)  not null  COMMENT '审批时间',
	primary key(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--公告表
create table net_notice(
	id int(20) NOT NULL AUTO_INCREMENT primary key COMMENT '主键id',
	title varchar(300) not null comment '标题',
	content MediumBlob  not null comment '内容',
	accepter varchar(5000) default '' comment '接收人',
	user_team varchar(20) comment '用户组别',
	user_visual varchar(10) comment '用户是否可见',
	send_time varchar(20) not null comment '发送时间'
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

alter table  net_notice modify column accepter varchar(5000) default ''
--第三方爬虫 

create table part3_task(
	id int(20) NOT NULL AUTO_INCREMENT primary key COMMENT '主键id',
	key_word varchar(300) not null comment '关键词',
	time_stamp varchar(28) not null comment '时间戳',
	time_set varchar(10) comment '扫描时间',
	key_url varchar(100) not null comment '网址',
	user_id varchar(60) comment '用户',
	task_id int(20) comment '任务号',
	first_time varchar(20) comment '第一次请求时间',
	rank_first  varchar(20) comment '第一次排名',
	rank_last varchar(20)  comment '第二次排名',
	second_time varchar(20) comment '第二次接受时间',
	note1 varchar(20)  comment '备用字段一',		--错误码
	note2 varchar(20)  comment '备用字段二',		--错误消息
	note3 varchar(20)  comment '备用字段三',
	note4 varchar(20)  comment '备用字段四',
	note5 varchar(20)  comment '备用字段五'
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;




insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (200001,"后台首页",100000,"后台首页","../firstManager/pageInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (210001,"监控网站库",100000,"网站异常监控","../../net/getNetInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (210002,"网站状态",100000,"网站异常监控","../../netMonitr/getNetMonitorInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (210003,"邮件情况",100000,"网站异常监控","../../netInfoMail/getNetInfoMail");

--monitor
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (220001,"关键词",100000,"管理优化","../netWordManager/getNetWordInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (220002,"每日提交",100000,"管理优化","../netWordManager/getDayNetWordInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (220003,"异常词",100000,"管理优化","../netWordManager/noPassWord");

--用户中心
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (230001,"用户列表",100000,"用户中心","../netWordManager/getInfoUser");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (230002,"代理维护",100000,"用户中心","../depManager/depManagerGetInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (230003,"功能维护",100000,"用户中心","../funcManager/getFuncList");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (230004,"修改资料",100000,"用户中心","../userManager/getUserDoucment");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (230005,"我的文档",100000,"用户中心","../downlaodManager/getDownlaodInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (230006,"充值消息设置",100000,"用户中心","../userMessageManager/getRechageMessage");


insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (240001,"价格查询",100000,"价格管理","../priceManager/getPriceList");

insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (250001,"发布信息",100000,"公告发布","../netNoticeManager/getNetNoticeInfoList");
--财务中心
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (260001,"财务明细",100000,"财务中心","../netFinanceManager/getFinanceInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (260002,"充值中心",100000,"财务中心","../netFinanceManager/getFinanceInfoCenter");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (260003,"所有用户列表",100000,"充值中心","../netAllUserManager/getAllUserInfo");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (260004,"所有用户列表",100000,"充值中心","../netFinanceManager/TestFirstDebit");
insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (260005,"所有用户列表",100000,"充值中心","../netFinanceManager/TestSecondDebit");


--更新功能表
update net_func set menu_id=concat(menu_id,',230005');
update net_func set menu_id=concat(menu_id,',250001') where role=1 and dep=1;
update net_func set menu_id=concat(menu_id,',230004') where role=1 and dep=1;
230006
update net_func set menu_id=concat(menu_id,',230006') where role=1

update net_func set menu_id=concat(menu_id,',260001') where role=1 and dep=7;
update net_func set menu_id=concat(menu_id,',260001') where role=2 and dep=7;

update net_func set menu_id=concat(menu_id,',260002') where role=1 and dep=1;
update net_func set menu_id=concat(menu_id,',260002') where role=1 and dep=1;
update net_func set menu_id=concat(menu_id,',260003') where role=1

update net_func set menu_id=concat(menu_id,',260004') where role=1 and dep=1;
update net_func set menu_id=concat(menu_id,',260005') where role=1 and dep=1;

--c4ca4238a0b923820dcc509a6f75849b
insert into net_user(user_id,dep,role,user_name,user_email,user_mobile,password) values ('adminMonitor',1,1,'管理员','bbc@126.com','1783666','c4ca4238a0b923820dcc509a6f75849b');
delete from net_user where user_id='netAdmin'

insert into net_user(user_id,dep_id,role_id,user_name,user_email,user_mobile,password,dep_name,role_name) values ('netAdmin',1,2,'管理员','bbc@126.com','1783666','c4ca4238a0b923820dcc509a6f75849b','网站部门','监控');
delete from net_func where dep='1' and role='2';
insert into net_func(dep,role,menu_id)value('1','2','220001,220002,220003')

--insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (220001,"数据量查询",100000,"数据量统计","../../netMonitr/getNetMonitorInfo");
--insert into net_menu(menu_id,menu_name,parent_id,parent_name,url) values (220002, "异常网站统计",100000,"数据量统计","../../netMonitr/getNetMonitorInfo");


insert into net_dept(dep_id,role_id,dep_name,role_name) values (1,1,'管理部','主管');
insert into net_dept(dep_id,role_id,dep_name,role_name) values (1,2,'xia','leadder');
--alter table 表名 add column 列名 varchar(30);

update net_menu set menu_name='级别维护' where id=15

--第三方爬虫
--请求参数：[wParam={"businessType":2006,"keyword":["百度","搜狗"],"searchOnce":true,"searchType":1010,"time":1514432735284,
"timeSet":[9,15],"url":["www.baidu.com","www.sougou.com"],"userId":"105661"}, wSign=a3d0e4f49079491e00036001ee7892cf, wAction=AddSearchTask]
--返回参数：{"xCode":0,"xMessage":"success.","xValue":[[6354304,""],[6354305,""]]}


create table out_spider(
	id int(255) NOT NULL AUTO_INCREMENT COMMENT '主键id',
	key_word varchar(200) not null COMMENT '关键词',
	net_address varchar(100) not null COMMENT '网址',
	xvalue varchar(30) COMMENT '任务号',
	err_code varchar(4)  COMMENT '错误码', 
	err_msg varchar(200)   COMMENT '错误消息',
	word_order varchar(3)  COMMENT '返回排名',
	send_time varchar(20)  COMMENT '发送时间',
	recv_time varchar(20)  COMMENT '返回时间'
	primary key(id)
))ENGINE=InnoDB  DEFAULT CHARSET=utf8;

create table user_message(
	id int not null primary key  AUTO_INCREMENT COMMENT '主键id',
	user_id varchar(30) COMMENT '用户ID',
	message varchar(300) COMMENT '消息'
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;



--首页存储过程
	create procedure proc_firstPage(in depId int,in roleId int,in userId varchar(60))
	begin
		declare total int  default 0;
		declare taskTotal int default 0;
		declare todayTotal int default 0;
		declare mothTotal int default 0;
		declare todaySale int default 0;
		declare userTotal int default 0;
		declare standtotal double default 0.00;
		declare baiduper double default 0.00;
		declare sumper double default 0.00;	
		declare custmerPer double default 0.00;
		declare yzCustmer int default 0;
		declare coupon double default 0.00;
	if depId=1&&roleId=1 then
		select count(0) from net_word where flag in('优化中','优化中(申请取消)','优化中(取消中)','停止优化','优化中(驳回)') into total;
		select count(0) from net_word where flag in('优化中','优化中(申请取消)','优化中(取消中)','优化中(驳回)') into taskTotal;
		select count(0) from net_word where word_order>=10  into todayTotal;
	  select count(money_debit) from net_finance where substr(debit_time,1,6)=(select extract(year_month from curdate()))  into mothTotal;
	  select count(0) from net_user where role_id=1 into userTotal;
	  select count(0) from net_word where word_order>10   into standtotal;
	  select count(0) from net_finance a,(select user_id as userCard,max(id)  as maxid from net_finance group by userCard) b where a.user_id=b.userCard and a.id=b.maxid and money_balance>0 into yzCustmer;
	  select count(money_debit) from net_finance where substr(debit_time,1,8)=(select replace(curdate(),'-',''))  into todaySale;
	  select sum(money_coupon) from net_finance into coupon;
	elseif(depId!=1&&roleId=1) then
		select count(0) from net_word where dep_id=depId and flag in('优化中','优化中(申请取消)','优化中(取消中)','停止优化','优化中(驳回)','优化中(处理中)') into total;
		select count(0) from net_word where dep_id=depId and flag in('优化中','优化中(申请取消)','优化中(取消中)','优化中(驳回)','优化中(处理中)') into taskTotal;
		select count(0) from net_word where word_order>10 and  dep_id=depId  into todayTotal;
		select count(money_debit) from net_finance where dep_id=depId and substr(debit_time,1,6)=(select extract(year_month from curdate())) into mothTotal;
		select count(0) from net_user where dep_id=depId into userTotal;  
	  select count(0) from net_word where word_order>10 and dep_id=depId into standtotal;
	  select count(0) from net_finance a,(select user_id as userCard,max(id)  as maxid from net_finance group by userCard) b where a.user_id=b.userCard and a.id=b.maxid and money_balance>0 and dep_id=depId into yzCustmer;
	  select count(money_debit) from net_finance where substr(debit_time,1,8)=(select replace(curdate(),'-','')) and dep_id=depId into todaySale;
	  select sum(money_coupon) from net_finance where dep_id=depId into coupon;
	else
		select count(0) from net_word where word_custmer=userId and flag in('优化中','优化中(申请取消)','优化中(取消中)','停止优化','优化中(驳回)','优化中(处理中)')  into total;
		select count(0) from net_word where word_custmer=userId and flag in('优化中','优化中(申请取消)','优化中(取消中)','优化中(驳回)','优化中(处理中)') into taskTotal;
	  select count(0) from net_word where word_order>10 and  word_custmer=userId  into todayTotal;
	  select count(money_debit) from net_finance where word_custmer=userId and substr(debit_time,1,6)=(select extract(year_month from curdate())) into mothTotal;
	  select count(0) from net_user where user_id=userId  into userTotal;
	  select count(0) from net_word where word_order>10 and word_custmer=userId into standtotal;
	  select count(0) from net_finance a,(select user_id as userCard,max(id)  as maxid from net_finance group by userCard) b where a.user_id=b.userCard and a.id=b.maxid and money_balance>0 and user_id=userId into yzCustmer;
	  select count(money_debit) from net_finance where substr(debit_time,1,8)=(select replace(curdate(),'-','')) and user_id=userId  into todaySale;
		select sum(money_coupon) from net_finance where user_id=userId into coupon;
	end if;
		if taskTotal>0 then
			set baiduper=standtotal/taskTotal;
			set sumper=standtotal/taskTotal;
			set custmerPer=yzCustmer/userTotal;
		end if;
			select total,taskTotal,todayTotal,sumper,baiduper,custmerPer,userTotal,mothTotal,todaySale,coupon;
	end
--用户列表存储过程
create procedure proc_allUserTitle(in deptId int,in roleId int,in userId varchar(200),in drag varchar(1))
begin
	declare dayIncrease int default 0;
	declare upIncrease int default 0;
	declare monthIncrease int default 0;
	declare custper double default 0;
	declare total int default 0;
	declare yzCustmer int default 0;
	declare custmerPer int default 0;
	declare upMonth varchar(6);
	declare montht varchar(6);
	declare dayt varchar(10);
	select extract(year_month from curdate()) into montht;
	select substr(replace(date_sub(date_sub(date_format(now(),'%y%m%d'),interval extract( day from now())-1 day),interval 1 month),'-',''),1,6) into upMonth;
	select replace(curdate(),'-','') into dayt;
	if deptId>1&&roleId=1 then
		select count(0) from net_user where substr(user_createtime,1,8)=dayt and dep_id=deptId into dayIncrease;
		select count(0) from net_user where substr(user_createtime,1,6)=upMonth and dep_id=deptId into upIncrease;
		select count(0) from net_user where substr(user_createtime,1,6)=montht and dep_id=deptId into monthIncrease;
		select count(0) from net_user where dep_id=deptId into total;
		select count(0) from net_finance a,(select user_id as userCard,max(id)  as maxid from net_finance group by userCard) b where a.user_id=b.userCard and a.id=b.maxid and money_balance>0 and dep_id=depId into yzCustmer;
	elseif deptId=1&&roleId=1 then
		if drag='p' then
			select count(0) from net_user where substr(user_createtime,1,8)=dayt and role_id=roleId into dayIncrease;
		elseif drag='u' then
			select count(0) from net_user where substr(user_createtime,1,8)=dayt into dayIncrease;
		end if;
		select count(0) from net_user where substr(user_createtime,1,6)=upMonth and role_id=roleId into upIncrease;
		select count(0) from net_user where substr(user_createtime,1,6)=montht and role_id=roleId into monthIncrease;
		select count(0) from net_user where role_id=roleId into total;
		select count(0) from net_finance a,(select user_id as userCard,max(id)  as maxid from net_finance group by userCard) b where a.user_id=b.userCard and a.id=b.maxid and money_balance>0 into yzCustmer;
	 else
		select count(0) from net_user where substr(user_createtime,1,8)=dayt and user_id=userId into dayIncrease;
		select count(0) from net_user where substr(user_createtime,1,6)=upMonth and user_id=userId into upIncrease;
		select count(0) from net_user where substr(user_createtime,1,6)=montht and user_id=userId into monthIncrease;
		set total=0;
	end if;
	if total>0 then 
		set custmerPer=yzCustmer/total;
	end if;
	select dayIncrease,upIncrease,monthIncrease,custper;
end


