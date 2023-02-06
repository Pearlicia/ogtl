// This implementation uses va_start, va_arg, and va_end from stdarg.h to access the arguments passed to my_printf.
//  The my_putchar function writes a single character to the standard output stream, my_putstr writes a string, 
//  and my_putnbr_base writes a number in the specified base. The my_printf function parses the format string and 
//  uses these functions to write the output.


#include <stdarg.h>
#include <unistd.h>

void my_putchar(char c)
{
    write(1, &c, 1);
}

void my_putstr(char *str)
{
    int i;

    i = 0;
    while (str[i])
        my_putchar(str[i++]);
}

void my_putnbr_base(int nbr, char *base)
{
    int len;

    len = 0;
    while (base[len])
        len++;
    if (nbr < 0)
    {
        my_putchar('-');
        nbr = -nbr;
    }
    if (nbr >= len)
        my_putnbr_base(nbr / len, base);
    my_putchar(base[nbr % len]);
}

int my_printf(char *format, ...)
{
    va_list args;
    int i;

    va_start(args, format);
    i = 0;
    while (format[i])
    {
        if (format[i] == '%')
        {
            i++;
            switch (format[i])
            {
                case 'c':
                    my_putchar(va_arg(args, int));
                    break;
                case 's':
                    my_putstr(va_arg(args, char *));
                    break;
                case 'd':
                    my_putnbr_base(va_arg(args, int), "0123456789");
                    break;
                case 'o':
                    my_putnbr_base(va_arg(args, int), "01234567");
                    break;
                case 'u':
                    my_putnbr_base(va_arg(args, int), "0123456789");
                    break;
                case 'x':
                    my_putnbr_base(va_arg(args, int), "0123456789abcdef");
                    break;
                case '%':
                    my_putchar('%');
                    break;
            }
        }
        else
            my_putchar(format[i]);
        i++;
    }
    va_end(args);
    return (0);
}
