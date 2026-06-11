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

# Colors
RESET   = \033[0m
BOLD    = \033[1m

RED     = \033[31m
GREEN   = \033[32m
YELLOW  = \033[33m
BLUE    = \033[34m
CYAN    = \033[36m

# Symbols
OK      = ✓
BUILD   = ▶
CLEAN   = ✗


all : $(NAME)

%.o : %.c $(INCLUDE)
	@printf "$(BLUE)$(BUILD) Compiling %-40s$(RESET)\n" "$(notdir $<)"
	@$(CC) $(CFLAGS) -c $< -o $@ $(READLINE_INC)

$(NAME) : $(LIBFT) $(OBJS) $(INCLUDE)
	@printf "$(CYAN)$(BUILD) Linking $(NAME)...$(RESET)\n"
	@$(CC) $(CFLAGS) $(OBJS) -o $(NAME) $(READLINE_LIB) -lreadline $(LIBFT)
	@printf "$(GREEN)$(BOLD)$(OK) Build complete: $(NAME)$(RESET)\n"

$(LIBFT) :
	@printf "$(YELLOW)$(BUILD) Building libft...$(RESET)\n"
	@$(MAKE) -C ./libft
	@test -f $(LIBFT) || (printf "$(RED)ERROR: libft.a not created$(RESET)\n" && exit 1)
	@printf "$(CYAN)$(BUILD) Continuing minishell build...$(RESET)\n"

clean :
	@printf "$(RED)$(CLEAN) Cleaning object files...$(RESET)\n"
	@rm -f $(OBJS)
	@$(MAKE) clean -C ./libft

fclean : clean
	@printf "$(RED)$(CLEAN) Removing binaries...$(RESET)\n"
	@rm -f $(NAME)
	@rm -f $(LIBFT)

re : fclean all