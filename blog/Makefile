all: index.html

POST_GENERATOR = make-blog-post.sh post-header.html post-footer.html Makefile blog-style.css
LIST_GENERATOR = make-blog-post-list.sh list-header.html list-footer.html Makefile blog-style.css

%/index.html: %/body.html $(POST_GENERATOR)
	bash ./make-blog-post.sh $^

index.html: $(wildcard */index.html) $(LIST_GENERATOR)
	# include only root index.html of each post
	bash ./make-blog-post-list.sh $(filter %/index.html, $^)

clean:
	rm */index.html
