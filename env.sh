for sh in /etc/env.d/*.sh ; do
  [ -r "$sh" ] && . "$sh"
done

