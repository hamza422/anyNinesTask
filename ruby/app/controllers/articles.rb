class ArticleController
  def create_article(article)
    article_not_exists =  (Article.where(:title => article['title']).empty?)
	
	if article_not_exists
	   new_article = Article.new(:title => article['title'], :content => article['content'], :created_at => Time.now)
	   
	   if new_article.save
		 { ok: true, obj: new_article }
	   end
    
	else
	    { ok: false, msg: 'Article with given title already exists' } 
	end
	
   end

  def update_article(id, new_data)

    article = Article.where(id: id).first
	
	if  article != nil and article.update(new_data)
	   { ok: true, obj: article }
	else
		 { ok: false, msg: 'Article could not be found' } # unless article.nil?
	end

  end
  

  def get_article(id)
    res = Article.where(:id => id)
	
    if !res.empty?
      { ok: true, data: res.first  }
    else
      { ok: false, msg: 'Article not found' }
    end
  rescue StandardError
    { ok: false }
  end

  def delete_article(_id)
  
	  article = Article.find_by(id: _id)

	  if article!=nil
		if article.destroy
		{ ok: true , delete_count: 1}
		end
	  else
	  { ok: false}
	  end
  end

  def get_batch
    res = Article.all
 
    if !res.empty?
      { ok: true, data: res }
    else
      { ok: false, msg: 'No article found' }
    end
  rescue StandardError
    { ok: false }
  end
end
