#include <unistd.h>
#include <stdarg.h>
#include <stdio.h>

char buf[100];

void itoabuf(unsigned int n, unsigned int base, char *buf, int *p)
{
    int i = 0;
    unsigned int num = n;

    do
    {
        buf[i++] = "0123456789abcdef"[num % base];
        num /= base;
    } while (num != 0);

    buf[i] = '\0';

    for (int j = 0; j < i / 2; j++)
    {
        char tmp = buf[j];
        buf[j] = buf[i - j - 1];
        buf[i - j - 1] = tmp;
    }

    *p = i;
}

int my_printf(const char *format, ...)
{
    va_list args;
    va_start(args, format);
    int written = 0;

    for (int i = 0; format[i]; i++)
    {
        if (format[i] == '%')
        {
            i++;
            int len;
            switch (format[i])
            {
            case 'o':
                itoabuf(va_arg(args, unsigned int), 8, buf, &len);
                write(1, buf, len);
                written += len;
                break;
            case 'u':
                itoabuf(va_arg(args, unsigned int), 10, buf, &len);
                write(1, buf, len);
                written += len;
                break;
            case 'x':
                itoabuf(va_arg(args, unsigned int), 16, buf, &len);
                write(1, buf, len);
                written += len;
                break;
            default:
                write(1, &format[i], 1);
                written++;
                break;
            }
        }
        else
        {
            write(1, &format[i], 1);
            written++;
        }
    }

    va_end(args);
    return written;
}
