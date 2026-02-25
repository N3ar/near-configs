(defun near/logseq-indent (beg end)
  "Indent Logseq blocks by inserting one literal TAB at BOL for each line."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (line-beginning-position) (line-end-position))))
  (save-excursion
    (let ((endm (copy-marker end)))
      (goto-char beg)
      (while (< (point) endm)
        (beginning-of-line)
        (insert "\t")
        (forward-line 1)))))

(defun near/logseq-outdent (beg end)
  "Outdent Logseq blocks by deleting one leading literal TAB at BOL for each line."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (line-beginning-position) (line-end-position))))
  (save-excursion
    (let ((endm (copy-marker end)))
      (goto-char beg)
      (while (< (point) endm)
        (beginning-of-line)
        (when (looking-at "\t")
          (delete-char 1))
        (forward-line 1)))))

;; Suggested bindings (works in most modes, including markdown/logseq md files)
(global-set-key (kbd "C-c >") #'near/logseq-indent)
(global-set-key (kbd "C-c <") #'near/logseq-outdent)
