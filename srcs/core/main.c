/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: aeddaqqa <aeddaqqa@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/03 05:19:40 by aeddaqqa          #+#    #+#             */
/*   Updated: 2021/01/03 11:11:10 by aeddaqqa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "headers.h"

int map[]=
{
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,
  1,0,0,0,0,0,0,0,0,0,0,0,0,1,
  1,0,0,0,0,1,0,0,0,0,0,0,0,1,
  1,0,0,0,0,0,0,0,0,0,1,0,0,1,
  1,0,0,0,0,0,0,0,0,0,1,0,0,1,
  1,0,0,0,0,1,0,0,0,0,1,0,0,1,
  1,0,0,0,0,0,0,0,0,0,1,0,0,1,
  1,0,0,0,0,1,0,0,0,0,1,0,0,1,
  1,0,0,0,0,0,0,0,0,0,0,0,0,1,
  1,0,0,0,0,1,0,0,0,0,0,0,0,1,
  1,0,0,0,0,1,0,0,0,0,0,0,0,1,
  1,0,0,0,0,1,0,0,0,1,0,0,0,1,
  1,0,0,0,0,0,0,0,0,0,0,0,0,1,
  1,1,1,1,1,1,1,1,1,1,1,1,1,1
};

int		main(int ac, char **av)
{
	t_doom *d;

	if (ac && av[0])
	{
		d = malloc(sizeof(t_doom));
		setup(d);
		while (d->upt.input.game)
		{
			process_input(&d->upt);
			update(d);
			render(d);
			init_keys(d);
		}
	}
	return (0);
}
