;;; lisp/rss-feeds.el -*- lexical-binding: t; -*-

(after! elfeed
  ;; Feed list
  (setq elfeed-feeds
        '("https://www.avyrss.com/feed/utah-avalanche-center/salt-lake"
          "https://rss.app/feeds/WFTFppsXgJ8GTpi6.xml"))

  ;; Additional configurations
  (add-hook! 'elfeed-search-mode-hook #'elfeed-update)
  (setq elfeed-search-filter "@1-year-ago +unread")
  )
