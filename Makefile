# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ayagoumi <ayagoumi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/25 10:38:14 by ayagoumi          #+#    #+#              #
#    Updated: 2020/12/27 10:55:48 by yait-el-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# Executable / Libraries.

RM              = rm -rf
SDL             = libsdl2.a
TTF             = libsdl2_ttf.a
IMG				= libSDL2_image.a
FT              = libft.a
LFTDIR			= libft
NAME            = Doom 
###########################shell 
WITH 			= $(shell tput cols)
HEIGHT			= $(shell tput lines)

BLACK        	:= $(shell tput -Txterm setaf 0)
RED          	:= $(shell tput -Txterm setaf 1)
GREEN        	:= $(shell tput -Txterm setaf 2)
YELLOW       	:= $(shell tput -Txterm setaf 3)
LIGHTPURPLE  	:= $(shell tput -Txterm setaf 4)
PURPLE       	:= $(shell tput -Txterm setaf 5)
BLUE         	:= $(shell tput -Txterm setaf 6)
WHITE        	:= $(shell tput -Txterm setaf 7)
RESET         	:= $(shell tput -Txterm setaf 9)
SPACE			:= $(shell tput -Txterm cup 20  50)
############################
INCSDIR 		:= inc
INCSDIR 		+= $(LFTDIR)
############################
SRCSDIR 		= srcs
OBJSDIR 		= objs
############################
INCS 			:= inc/wolf_3d.h
INCS 			+= libft/libft.h
############################################
SRC 			:= main.c
#############################################
UNAME := $(shell uname -s)

ifeq ($(UNAME), Darwin)
	LSDLDIR     = $(HOME)/.brew/Cellar/sdl2/2.0.12_1/lib
	LTTFDIR     = $(HOME)/.brew/Cellar/sdl2_ttf/2.0.15/lib
	LIMGDIR 	= $(HOME)/.brew/Cellar/sdl2_image/2.0.5/lib
	INCSDIR     += $(HOME)/.brew/Cellar/sdl2/2.0.12_1/include/SDL2
	INCSDIR     += $(HOME)/.brew/Cellar/sdl2_ttf/2.0.15/include/SDL2
	INCSDIR		+= $(HOME)/.brew/Cellar/sdl2_image/2.0.5/include/SDL2
else
	SDL       = libSDL2.a
	TTF       = libSDL2_ttf.a
	IMG       = libSDL2_image.a
	LULIBS    = /usr/lib/x86_64-linux-gnu/
	LUINCS    = /usr/include/
	LTTFDIR	  = $(LULIBS)
	LSDLDIR	  = $(LULIBS)
	LIMGDIR	  = $(LULIBS)
	INCSDIR	  = $(LUINCS)/SDL2 
endif
########################################3Linked libraries at compile time.
#LIBS            := -framework SDL2 -F ./SDL/ 
#LIBS            += -framework SDL2_image -F ./SDL/
#LIBS			+= -framework SDL2_ttf -F ./SDL/
#LIBS			+= -rpath @loader_path/SDL
LIBS            := -L$(LSDLDIR) -lSDL2
LIBS            += -L$(LTTFDIR) -lSDL2_ttf
LIBS			+= -L$(LIMGDIR) -lSDL2_image
LIBS            += -L$(LFTDIR) -lft
LIBS            += -lm
LIBS			+= -lz
LTTF             = $(LTTFDIR)/$(TTF)
LFT              = $(LFTDIR)/$(FT)
LSDL             = $(LSDLDIR)/$(SDL)
LTTF             = $(LTTFDIR)/$(TTF)
LIMG			 = $(LIMGDIR)/$(IMG)
D_SRCS           = $(addsuffix /, $(SRCSDIR))
D_OBJS           = $(addsuffix /, $(OBJSDIR))
C_OBJS           = $(addprefix $(D_OBJS),  $(SRC:.c=.o))
	C_INCS           = $(foreach include, $(INCSDIR), -I$(include))
	CC              = gcc

# Compilation flags.

CFLAGS          = $(C_INCS) -Wall -Wextra -Werror
#----------------->>>>>>>>>>>>>>>>START<<<<<<<<<<<<<-------------------#
$(D_OBJS)%.o: $(D_SRCS)%.c $(INCS)
	@echo "$(PURPLE)**********>>>Compiling : $(RESET) $(LIGHTPURPLE)" $<
	@$(CC) $(CFLAGS) -c $< -o $@ 


all:$(OBJSDIR) $(C_OBJS) $(NAME)


$(NAME):  $(LFT)  $(LSDL) $(LIMG) $(LTTF)  $(C_OBJS)
	@echo "$(RED)\n***********>>>Building : $(RESET)$(NAME) $(YELLOW)...\n$(RESET)"
	@$(CC) $(CFLAGS) -o $(NAME) $(C_OBJS) $(LIBS)
	@echo "$(GREEN)***   successfully compiled   ***\n$(RESET)"
	@echo " ----------------------------------------------------"
	@echo "|$(RED)                       Wolf-3D                 $(RESET)     |"
	@echo "|----------------------------------------------------|"
	@echo "| $(LIGHTPURPLE)Options:$(RESET)                                           |"
	@echo "|                                                    |"
	@echo "| L:$(YELLOW)Show Light$(RESET)              | K:$(YELLOW)Dim Light$(RESET)            |"
	@echo "|                                                    |"
	@echo "| +:$(YELLOW)Up The darkness$(RESET)         |-:$(YELLOW)Dim darkness$(RESET)          |"
	@echo "|                                                    |"
	@echo "| w,d,s,a: $(YELLOW)Mouvement$(RESET)                                 |"
	@echo "|                                                    |"
	@echo "| ->: <-: $(YELLOW)Up key: Down Key:$(RESET)                          |"
	@echo "|                                                    |"
	@echo "| ESC: $(YELLOW)Quit$(RESET)                                          |"
	@echo " ----------------------------------------------------"

print-%  : ; @echo $* = $($*)

####  make libft

$(LFT):
	@make -sC $(LFTDIR)

### creating files for object.o
$(LSDL):
	@echo "$(GREEN)***   Installing library sdl2   ...  ***\n$(RESET)"
	@brew install sdl2 > /dev/null 2>&1;

$(LTTF):
	@echo "$(GREEN)***   Installing library sdl2_ttf   ...  ***\n$(RESET)"
	@brew install sdl2_ttf > /dev/null 2>&1;

$(LIMG):
	@echo "$(GREEN)***   Installing library sdl2_image    ...  ***\n$(RESET)"
	@brew install sdl2_image > /dev/null 2>&1;
$(OBJSDIR):
	@mkdir -p $(OBJSDIR)
	##### creating space
	# Deleting all .o files.

clean:
	@make -sC $(LFTDIR) clean
	@echo "$(GREEN)**********   Deleting all object from $(NAME) **********\n$(RESET)"
	@$(RM) $(C_OBJS)

fclean: clean
	@make -sC $(LFTDIR) fclean
	@echo "$(GREEN)**********   Deleting $(NAME) **********\n$(RESET)"
	@$(RM) $(NAME)
	@$(RM) $(OBJSDIR)

re: fclean all
.PHONY: all clean fclean re
