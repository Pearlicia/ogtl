#include <stdarg.h>
#include <unistd.h>
#include <unistd.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>


char buf[100];

void itoabuf(unsigned int n, unsigned int base, char *buf, int *p)
{   

    int i = 0;
    unsigned int num = n;


    do
    {
        buf[i++] = "0123456789ABCDEF"[num % base];
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

void my_putchar(char c)
{
    write(1, &c, 1);
}

int my_putstr(char *str)
{
    int i = 0;
    while (str[i])
        my_putchar(str[i++]);
    return (i);
}

int my_put_nbr(int nb)
{
    int len = 0;
    if (nb < 0)
    {
        my_putchar('-');
        nb = -nb;
        len++;
    }
    if (nb >= 10)
        len += my_put_nbr(nb / 10);
    my_putchar(nb % 10 + 48);
    len++;
    return (len);
}

int my_printf(const char *format, ...)
{
    va_list args;
    int i = 0, len = 0;

    va_start(args, format);
    while (format[i])
    {
        if (format[i] == '%')
        {
            i++;
            int lent;
            switch (format[i])
            {
                case 'd':
                    len += my_put_nbr(va_arg(args, int));
                    break;
                case 'o':
                    itoabuf(va_arg(args, unsigned int), 8, buf, &lent);
                    write(1, buf, lent);
                    len += lent;
                    break;
                case 'u':
                    itoabuf(va_arg(args, unsigned int), 10, buf, &lent);
                    write(1, buf, lent);
                    len += lent;
                    break;
                case 'x':
                    itoabuf(va_arg(args, unsigned int), 16, buf, &lent);
                    write(1, buf, lent);
                    len += lent;
                    break;
                case 's':
                    len += my_putstr(va_arg(args, char *));
                    break;
                case 'c':
                    my_putchar(va_arg(args, int));
                    len++;
                    break;
                case '%':
                    my_putchar('%');
                    len++;
                    break;
                default:
                    my_putchar('%');
                    my_putchar(format[i]);
                    write(1, &format[i], 1);
                    len++;
                    len += 2;
                    break;
            }
        }
        else
        {
            my_putchar(format[i]);
            len++;
        }
        i++;
    }
    va_end(args);
    return (len);
}