<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="public/headercss.jsp"/>
 <link rel="stylesheet" href="../static/editor/css/style.css" />
 <link rel="stylesheet" href="../static/editor/css/editormd.css" />
        <style>
            input[type="file"]
      {
        position: absolute;
        left: 0;
        top: 0;
        height: 200px;
        opacity: 0;
        cursor: pointer;
    }
        </style>
<!--        预览图片 -->
        <script type="text/javascript">
    function prev(event){
        //获取展示图片的区域
        var img = document.getElementById("prevView"); 
        //获取文件对象
        let file = event.files[0];
        //获取文件阅读器
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function(){
            //给img的src设置图片url
            img.setAttribute("src", this.result);
        }
    }
</script>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
            <fieldset class="layui-elem-field layui-field-title">
              <legend>修改文章</legend>
            </fieldset> 
    <form class="layui-form"   id="myForm"  method="POST" enctype="multipart/form-data">
<div class="layui-col-md8">
	<div align="center">
        <div class="layui-form-item"  style="width: 90%;" >
                <input type="text" name="articleTitle" id="articleTitle" value="${article.articleTitle }" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
        </div>
</div>
        <div class="layui-form-item layui-form-text">
        <div id="layout" style="width:100%;background: #f6f6f6;">
            <div class="editormd" id="test-editormd">
<textarea class="editormd-markdown-textarea" name="markdownContent" id="category_content">${article.markdownContent }</textarea>
<!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
<textarea class="editormd-html-textarea" name="htmlContent"></textarea>

</div>
        
        	<div align="center">
        <div>
        
               <blockquote class="layui-elem-quote layui-quote-nm">
            温馨提示：<br>
            1、文章内容的数据表字段类型为MEDIUMTEXT,每篇文章内容请不要超过500万字 <br>
            2、写文章之前，请确保标签和分类存在，否则可以先新建；请勿刷新页面，博客不会自动保存 <br>
			3.  写的文章前俩个空格段将做为文章summary,大标题前会自动有空格段
        </blockquote>
        </div>
        </div>  
        </div>
        </div>
</div>


<div class="layui-col-md4">
<div style="width:350px">
        <div class="layui-card">
          <div class="layui-card-header"><h2>发布</h2></div>
          <hr class="layui-bg-black">
          
          <input type="hidden" name="articleId" value="${article.articleId}"/>
          
          <div class="layui-card-body layui-text">
         <img src="${ pageContext.request.contextPath}${article.articleImagePath }" alt="" width="300" height="200" id="prevView">
    	 <input type="file" name="articleImage" id="" value="default.jpg" onchange="prev(this)"/>        
            <table class="layui-table">
              <colgroup>
                <col width="100">
                <col>
              </colgroup>
                  <label class="layui-form-label" style="width: 100px;">文章类型：</label>
                  	
                  <div class="layui-input-block">
                    <select name="articleType" lay-verify="required" lay-filter="aihao">
                                        <c:choose>
                    <c:when test="${article.articleType eq 1 }">
                      <option value="1" selected="true">原创</option>
                      <option value="0" >转载</option>
                      </c:when>
                      <c:otherwise>
                                <option value="1" >正文</option>
                      <option value="0" selected="true">转载</option>
                      </c:otherwise>
                    </c:choose>
                    </select>
                  </div>
                                <label class="layui-form-label" style="width: 100px;">发布类型：</label>
                  <div class="layui-input-block">
                    <select name="issueType" lay-verify="required" lay-filter="aihao">
                    <c:choose>
                    <c:when test="${article.issueType eq 1 }">
                      <option value="1" selected="true">正文</option>
                      <option value="0" >草稿</option>
                      </c:when>
                      <c:otherwise>
                                <option value="1" >正文</option>
                      <option value="0" selected="true">草稿</option>
                      </c:otherwise>
                    </c:choose>

                    </select>
                    <br>
                         <button class="layui-btn" type="button" id="issue">确认修改</button>
                <button type="reset" class="layui-btn layui-btn-primary" onclick="getCateIds()">重置</button>
                  </div>
            </table>
                </div>
          </div>
        </div>
        
                <div class="layui-card">
          <div class="layui-card-header"><h2>文章分类</h2></div>
          <hr class="layui-bg-black">
          <div class="layui-card-body layui-text">
            <table class="layui-table">
              <colgroup>
                <col width="100">
                <col>
              </colgroup>
                     <c:forEach items="${categories}" var="category">         
                    <input type="checkbox" name="articleCategoryId" lay-skin="primary" title="${category.categoryName }" value="${category.categoryId}"><br>
                    <c:forEach items="${category.childrenCategory}" var="c">
                     &nbsp;	&nbsp;	&nbsp;	<input type="checkbox" name="articleCategoryId" lay-skin="primary" title="${c.categoryName }" value="${c.categoryId }"><br>
                     </c:forEach>
					</c:forEach>
            </table>
          </div>
        </div>
               <div class="layui-card">
          <div class="layui-card-header"><h2>标签</h2></div>
          <hr class="layui-bg-black">
          <div class="layui-card-body layui-text">
            <table class="layui-table">
              <colgroup>
                <col width="100">
                <col>
              </colgroup>
              <c:forEach items="${tags}" var="tag">
                    <input type="checkbox" name="articleTagId" lay-skin="primary" title="${tag.tagName }" value="${tag.tagId }">
			</c:forEach>
            </table>
          </div>
        </div>
       
        </div>

    </form>

        </div>

    </div>

<jsp:include page="public/headerjs.jsp"/>

  <script src="${pageContext.request.contextPath}/static/editor/editormd.js"></script>
<!--填补复选框得值 -->
        <script>
        tagList = [];
        categoryList = [];
        tagList = "${articletags}".replace('[','').replace(']','').split(',');
        categoryList = "${articlecategories}".replace('[','').replace(']','').split(',');
        console.log(tagList);
        console.log(categoryList);
        for(var i=0,len=tagList.length;i<len;i++)
        	{
            $("input[Value="+tagList[i]+"][name='articleTagId']").attr("checked", "checked");
        	}
        for(var j=0,lens=categoryList.length;j<lens;j++)
    	{
        $("input[Value="+categoryList[j]+"][name='articleCategoryId']").attr("checked", "checked");

    	}
        </script>

        <script type="text/javascript">
            $(function() {                
                var testEditor = editormd("test-editormd", {
                    width: "90%",
                    height: 1300,
                    markdown : "",
                    path : '../static/editor/lib/',
                    syncScrolling : "single",
                    emoji : true,
                    saveHTMLToTextarea : true,
                    tocm : true, // Using [TOCM]
                    tex : true, // 开启科学公式TeX语言支持，默认关闭
                    flowChart : true, // 开启流程图支持，默认关闭
                    /* 上传图片配置 */
                    imageUpload : true,
                    imageFormats : [ "jpg", "jpeg", "gif", "png", "bmp", "webp" ],
                    imageUploadURL : "${pageContext.request.contextPath}/upload/article_image", //注意你后端的上传图片服务地址
                });
            });
        </script>


        <script>
        $("#issue").on("click",function(){
 		var title=$("#articleTitle").val();
 		var content=$("#category_content").val();
 		if(title&&content){
 		$.ajax({
    	type: "POST",
    	url: '${pageContext.request.contextPath}/admin/editor_article',
    	data: new FormData($("#myForm" )[0]),
    	cache: false,
    	async: false,
    	processData: false,
    	contentType: false,
    	dataType:"json",
    	success: function (data) {
    	console.log(data.success);
        if(data.success===true){
            layer.alert(data.msg,{icon:1});
            // javaex.loading({
            //     content:"博客内容正在修改中，请稍后......"
            // });
            // setTimeout(function() {
            //     layer.alert(data.msg,{icon:1});
            // }, 1000);
        }else
        	layer.alert(data.msg,{icon:5});
   			 }
				});
 		}else
 			{
 			layer.alert("标题和正文不能为空");
 			}
        });
        
        
</script>
</body>
</html>
