#include <unistd.h>
#include <stdarg.h>
#include <string.h>

int my_printf(const char *format, ...)
{
    va_list args;
    int ret = 0;
    va_start(args, format);
    for (const char *p = format; *p != '\0'; ++p)
    {
        if (*p != '%')
        {
            char c = *p;
            ret += write(1, &c, 1);
            continue;
        }
        ++p;
        switch (*p)
        {
        case 's':
        {
            const char *str = va_arg(args, const char *);
            if (str == NULL)
                str = "(null)";
            ret += write(1, str, strlen(str));
            break;
        }
        case '%':
        {
            char c = '%';
            ret += write(1, &c, 1);
            break;
        }
        default:
            // Unsupported format specifier
            break;
        }
    }
    va_end(args);
    return ret;
}
