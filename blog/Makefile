all: index.html

POST_GENERATOR = make-blog-post.sh post-header.html post-footer.html Makefile blog-style.css
LIST_GENERATOR = make-blog-post-list.sh list-header.html list-footer.html Makefile blog-style.css

%/index.html: %/body.html $(POST_GENERATOR)
	bash ./make-blog-post.sh $^

POSTS=$(patsubst %/body.html,%/index.html, $(wildcard */body.html))

index.html: $(POSTS) $(LIST_GENERATOR)
	bash ./make-blog-post-list.sh $(patsubst %/body.html, %/index.html, $(POSTS))

clean:
	rm */index.html
	rm index.html
