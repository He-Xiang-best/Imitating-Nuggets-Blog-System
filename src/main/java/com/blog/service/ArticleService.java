package com.blog.service;

import com.blog.entity.Article;

import java.util.List;
import java.util.Map;

public interface ArticleService {
	public List<Article>listArticle(Map<String, Object>map);
	public List<Article>listAdminArticle(Map<String, Object>map);
	public List<Article> getArticleByAidMap(Map<String,Object> map);
	public List<Article>listUserArticle(Map<String, Object>map);
	public List<Article>lisRecenttArticle(Integer pageSize);
	public Integer commentReduce(Integer article_id);
	public Integer countArticle();
	public Article getArticleByAid(Integer articleId);
	public Integer addCommentCount(Integer articleId);
	public Integer insertArticle(Article article);
	public Integer getAidByTitle(String articleTitle);
	public Integer updateArticle(Article article);
	public Integer deleteArticle(Integer articleId);
	public Article getPreArticle(Integer articleId);
	public Article getNextArticle(Integer articleId);
	public Integer deleteArticleByUserId(Map<String, Object> map);
	public List<Integer> getAiticleIdList(Map<String, Object> map);
}
