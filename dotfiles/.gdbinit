python
import os, sys
if (os.environ.get('TERM') == 'xterm-256color'
        and not os.environ.get('INSIDE_EMACS')
        and not os.environ.get('ECLIPSE_HOME')
        and sys.stdin.isatty()):
    gdb.execute('source ~/.gef-2026.01.py')
end
