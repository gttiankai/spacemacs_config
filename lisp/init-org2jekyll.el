(require 'org)
(require 'org2jekyll)
(custom-set-variables '(org2jekyll-blog-author "tiankai")
                      '(org2jekyll-source-directory (expand-file-name "/Users/tiankai/git-hub/gttiankai.github.io/"))
                      '(org2jekyll-jekyll-directory (expand-file-name "/Users/tiankai/git-hub/gttiankai.github.io/"))
                      '(org2jekyll-jekyll-drafts-dir "_org/")
                      '(org2jekyll-jekyll-posts-dir "_posts/")
                      '(org-publish-project-alist
                        `(("default"
                           :base-directory ,(org2jekyll-input-directory)
                           :base-extension "org"
                           :publishing-directory ,(org2jekyll-output-directory)
                           :publishing-function org-html-publish-to-html
                           :headline-levels 4
                           :section-numbers nil
                           :with-toc nil
                           :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>"
                           :html-preamble t
                           :recursive t
                           :make-index t
                           :html-extension "html"
                           :body-only t)
                          ("post"
                           :base-directory ,(org2jekyll-input-directory)
                           :base-extension "org"
                           :publishing-directory ,(org2jekyll-output-directory org2jekyll-jekyll-posts-dir)
                           :publishing-function org-html-publish-to-html
                           :headline-levels 4
                           :section-numbers nil
                           :with-toc nil
                           :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>"
                           :html-preamble t
                           :recursive t
                           :make-index t
                           :html-extension "html"
                           :body-only t)
                          ("images"
                           :base-directory ,(org2jekyll-input-directory "public/img")
                           :base-extension "jpg\\|gif\\|png"
                           :publishing-directory ,(org2jekyll-output-directory "public/img")
                           :publishing-function org-publish-attachment
                           :recursive t)
                          ("js"
                           :base-directory ,(org2jekyll-input-directory "public/js")
                           :base-extension "js"
                           :publishing-directory ,(org2jekyll-output-directory "public/js")
                           :publishing-function org-publish-attachment
                           :recursive t)
                          ("css"
                           :base-directory ,(org2jekyll-input-directory "public/css")
                           :base-extension "css\\|el"
                           :publishing-directory ,(org2jekyll-output-directory "public/css")
                           :publishing-function org-publish-attachment
                           :recursive t)
                          ("web" :components ("images" "js" "css"))
                          )
                        )
                      )

(org2jekyll-mode)

(provide 'init-org2jekyll)
