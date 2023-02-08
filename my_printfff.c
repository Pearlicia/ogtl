#include <stdarg.h>
#include <unistd.h>

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
            switch (format[i])
            {
                case 'd':
                    len += my_put_nbr(va_arg(args, int));
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



















// #include <unistd.h>
// #include <stdarg.h>
// #include <stdio.h>
// #include <stdlib.h>

// void    my_putchar(char c)
// {
//     write(1, &c, 1);
// }

// void    my_putstr(char *str)
// {
//     int i = 0;

//     while (str[i])
//         i++;
//     write(1, str, i);
// }

// void    my_put_nbr(int n)
// {
//     if (n < 0)
//     {
//         my_putchar('-');
//         n = -n;
//     }
//     if (n > 9)
//         my_put_nbr(n / 10);
//     my_putchar(n % 10 + '0');
// }

// int     my_printf(const char *fmt, ...)
// {
//     va_list ap;
//     int i;

//     i = 0;
//     va_start(ap, fmt);
//     while (fmt[i])
//     {
//         if (fmt[i] == '%')
//         {
//             i++;
//             switch (fmt[i])
//             {
//                 case 'd':
//                     my_put_nbr(va_arg(ap, int));
//                     break;
//                 case 's':
//                     my_putstr(va_arg(ap, char*));
//                     break;
//                 case 'c':
//                     my_putchar((char)va_arg(ap, int));
//                     break;
//                 case 'o':
//                     my_putstr("0");
//                     my_put_nbr(va_arg(ap, int));
//                     break;
//                 case 'u':
//                     my_put_nbr(va_arg(ap, unsigned int));
//                     break;
//                 case 'x':
//                     my_putstr("0x");
//                     my_put_nbr(va_arg(ap, unsigned int));
//                     break;
//                 case 'p':
//                     my_putstr("0x");
//                     my_put_nbr((unsigned long)va_arg(ap, void*));
//                     break;
//                 default:
//                     my_putchar(fmt[i]);
//                     break;
//             }
//         }
//         else
//             my_putchar(fmt[i]);
//         i++;
//     }
//     va_end(ap);
//     return (0);
// }
