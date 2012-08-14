# bluid html from markdown
# it's for https://github.com/progit/progit
# git://github.com/progit/progit.git
# install markdown
# 2012-06-07
# bakup old file
# 2011-06-10 orignally by opengit.org , 19:13 2012/3/12 modified by 荒野无灯
# changelog: 修改了下css字体和html DOCTYPE,增加对windows支持。
# put the file in / of object
 

if [ $# -ne 1 ]; then
    read -p 'put a language shortname：' lang
else
    lang=$1
fi
out=progit_$lang.html
if [ -f progit_$lang.html ];then
    mv progit_$lang.html progit_$lang.html.`date +%Y%m%d%H%M%S`.bak
fi
echo $lang
echo $out
touch $out
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<style type="text/css"><!--body{margin:0 20px;font-size:14px;font-family:"Microsoft YaHei","WenQuanYi ZenHei";}pre{margin:1em 0;font-size:13px;background-color:#eee;border:1px solid #ddd;padding:5px;line-height:1.5em;color:#444;overflow:auto;border-radius:3px;}code{background:#eee;}pre,code{font-family:"Deja Vu Sans Mono",Consolas,Monaco,"Courier New",Courier,monospace;}h1{text-align:center;margin-top:30px;color:green}h2{color:#6EA2F8}h3{color:#EE7D2F}.page{border:2px solid #333;background:#333;margin: 30px 0;}img{max-width:600px;display:block;text-align:center;border-radius:5px;}--></style>
	</head><body>' >> $out
for i in `ls $lang/`
    do 
    list=`find $lang/$i -iname "*.markdown"`
    #html=$lang/${i/\//\.html}
    html=$lang/$i/$i.html
    #uncomment below for Linux	
    #markdown -v -o 'html4' $list -f $html
    #for windows
    php ./markdown.php $list $html
    cat $html >> $out
    rm $html
    echo '<div class="page"></div>' >> $out
    echo "get $list; markdown2html add to $out"
done
echo '</body></html>' >> $out;

#add by gdbdzgd insert image and put image in the center for zh only
grep  "Insert [0-9]*[a-z]*[0-9]*" -o  $out |while read f
do
	 sed -i  "s/${f}.png/<img src=\"figures\/${f##Insert }-tn.png\" \/>/g" $out
done

sed -i  "/图 [0-9]-[0-9]\./a </div>" $out
sed -i  "/[0-9]*[a-z]*[0-9]*-tn.png/i <div align=\"center\"> " $out
