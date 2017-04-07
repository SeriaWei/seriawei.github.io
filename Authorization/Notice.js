var ele = document.createElement("div");
ele.innerHTML = '<p>欢迎使用<a href="http://www.zkea.net/zkeacms" target="_blank">ZKEACMS</a> <strong>您的网站未授权</strong> <a href="http://www.zkea.net/zkeacms/price" target="_blank">立即授权</a> <a href="http://www.zkea.net/licenses" target="_blank">查看协议</a></p><em>授权后将不再显示该信息</em>';
ele.className = "panel-body text-center bg-danger";
document.body.appendChild(ele);