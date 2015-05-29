case ":${PATH:-}:" in
    *:/usr/local/eclipse:*) ;;
    *) PATH="/usr/local/eclipse${PATH:+:$PATH}" ;;
esac

