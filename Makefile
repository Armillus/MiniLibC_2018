###################################
#				  #
#	     Makefile	  	  #
#				  #
###################################

NASM	=	nasm

CC	=	ld

NASMFLAGS	=	-f elf64 -Ox -Wall

CCFLAGS =	-shared

RM	=	rm -f

NAME	=	libasm.so

SRCS	=	src/strlen.asm		\
		src/strchr.asm		\
		src/memset.asm		\
		src/memcpy.asm		\
		src/memmove.asm	\
		src/rindex.asm		\
		src/strcasecmp.asm	\
		src/strcmp.asm		\
		src/strncmp.asm	\
		src/strstr.asm		\
		src/strpbrk.asm	\
		src/strcspn.asm

BONUS_SRCS	=	bonus/strdup.asm	\
			bonus/strcat.asm    \
			bonus/strcpy.asm    \

OBJS	=	$(SRCS:.asm=.o)

BONUS_OBJS	=	$(BONUS_SRCS:.asm=.o)

%.o: %.asm
	$(NASM) $< $(NASMFLAGS) -o $@

all: $(NAME)

bonus: $(BONUS_OBJS)
	$(CC) $(CCFLAGS) $^ -o $(NAME)

$(NAME):    $(OBJS) $(BONUS_OBJS)
	$(CC) $(CCFLAGS) $(OBJS) $(BONUS_OBJS) -o $(NAME)

clean:
	$(RM) $(OBJS) $(BONUS_OBJS)

fclean:	clean
	$(RM) $(NAME)
	$(RM) $(LIB)

re: fclean all

.PHONY: clean fclean all re bonus
