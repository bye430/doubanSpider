#########################################################################
# File Name: pachong.sh
# Author: keemun
# 豆瓣读书爬虫
# Created Time: 2017年12月07日 星期四 21时46分39秒
#########################################################################
#!/bin/bash
tags="
东野圭吾
科幻
言情
悬疑
奇幻
武侠
日本漫画
韩寒
亦舒
三毛
网络小说
安妮宝贝
郭敬明
穿越
金庸
阿加莎·克里斯蒂
轻小说
科幻小说
几米
青春文学
魔幻
幾米
张小娴
J.K.罗琳
古龙
高木直子
沧月
落落
张悦然
校园
历史
心理学
哲学
传记
文化
社会学
艺术
宗教
电影
数学
回忆录
中国历史
思想
国学
人文
音乐
人物传记
绘画
艺术史
戏剧
佛教
军事
二战
西方哲学
近代史
自由主义
美术
爱情
旅行
生活
成长
励志
心理
教育
健康
养生
经济学
管理
经济
创业
企业史
科普
互联网
编程
科学
算法
科技
web
通信
神经网络
程序"
function pachong(){
j=1;
while [ 1 ]
do 
#j表示第几页，i为当前页的第一本书，a用于辅助计算
	a=$((j-1));
	i=$((a*20));
	flag=-1;
#每三秒爬一页
	sleep 3
#finishedflag表示当前标签是否爬完
	if [ -f "finishedflag" ] ;then
		rm finishedflag
	fi
#ratingflag为1则当前读到的$line是评分,否则是书名
	ratingflag=1
#下载并提取书名和评分，保存到bookdata当中
 	curl "https://book.douban.com/tag/${1}?start=$i&type=T" >curl
	cat curl|egrep  -e 'title=".*"' -e 'rating_nums'|sed 's/^.*title=\"\([^"]*\)\"/\1/'|sed 	's:^.*\([0-9]\.[0-9]\)</span>:\1:'|sed '/^.*value.*$/d'|while read line;
	do 
		touch finishedflag;
		ratingflag=`echo $line|egrep '^[0-9]\.[0-9]$'|wc -l`
		if [ $ratingflag -eq 0 ];then
			name=$line
		else 
			echo $name >>$line
		fi
	done

if [ ! -f "finishedflag" ] ;then
return 0
fi
#跳转到下一页
j=$((j+1));
done;
}

for tag in `echo $tags`
do 
echo $tag
 pachong $tag
done

