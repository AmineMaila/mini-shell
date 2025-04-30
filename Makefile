# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmaila <mmaila@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/29 13:42:04 by mmaila            #+#    #+#              #
#    Updated: 2025/04/30 19:42:42 by mmaila           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME            =       minishell

CC              =       cc

# OS detection
UNAME_S         :=      $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	READLINE_INC    =
	READLINE_LIB    =
else ifeq ($(UNAME_S), Darwin)
	READLINEDIR     = $(shell brew --prefix readline)
	READLINE_INC    = -I$(READLINEDIR)/include
	READLINE_LIB    = -L$(READLINEDIR)/lib
endif

CFLAGS          =       -Wall -Werror -Wextra

LIBFT           =       ./libft/libft.a

INCLUDE         =       ./Includes/minishell.h ./libft/libft.h

SRCS			= 		\
						./parsing/tokenize.c \
						./parsing/tokenize_quotes.c \
						./parsing/tokenize_utils.c \
						./parsing/flag_utils.c \
						./parsing/flag.c \
						./parsing/table.c \
						./parsing/table_utils.c \
						./parsing/exit.c \
						./parsing/parse.c \
						./parsing/expand_utils.c \
						./parsing/expand.c \
						./parsing/set_fds.c \
						./utils/ft_lstadd_back.c \
						./utils/ft_lstnew.c \
						./utils/ft_lstclear.c \
						./utils/ft_lstdelone.c \
						./utils/ft_strcmp.c \
						./exec/execute.c \
						./exec/here_doc.c \
						./exec/command.c \
						./exec/get_next_line/get_next_line.c \
						./exec/get_next_line/get_next_line_utils.c \
						./builtins/echo.c \
						./builtins/builtin.c \
						./builtins/pwd.c \
						./builtins/unset.c \
						./builtins/env.c \
						./builtins/export.c \
						./builtins/cd.c \
						./builtins/exit.c \
						./env.c \
						./signals.c \
						./main.c

OBJS			= 		$(SRCS:.c=.o)

all : $(NAME)

%.o : %.c $(INCLUDE)
	@echo "\033[5;34mCompiling ${notdir $<}\033[0m"
	@$(CC) $(CFLAGS) -c $< -o $@ $(READLINE_INC)

$(NAME) : $(LIBFT) $(OBJS) $(INCLUDE)
	@$(CC) $(CFLAGS) $(OBJS) -o $(NAME) $(READLINE_LIB) -lreadline $(LIBFT) 
	@echo "\033[1;32mSUCCESS\033[0m"

$(LIBFT) :
	@echo "\033[1;33mBuilding LIBFT...\033[0m"
	@make -C ./libft
	@test -f $(LIBFT) || (echo "\033[1;31mERROR: libft.a not created\033[0m" && exit 1)
	@echo "\033[1;33mBuilding Minishell...\033[0m"

clean :
	@echo "\033[3;31mCleaning...\033[0m"
	@rm -rf $(OBJS)
	@make clean -C ./libft

fclean : clean
	@rm -rf $(NAME) $(OBJS)
	@rm -rf $(LIBFT)

re : fclean all

