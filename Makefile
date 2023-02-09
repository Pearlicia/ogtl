CC=gcc #compiler
TARGET=my_ngram #target file name

all: 
	$(CC) my_ngram.c -o $(TARGET)


clean:
	rm -f *.o

fclean: clean
	rm -f $(TARGET)

re: fclean all