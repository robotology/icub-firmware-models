/*
 * Copyright (C) 2022 iCub Tech Facility - Istituto Italiano di Tecnologia
 * Author:  Valentina Gaggero
 * email:   valentina.gaggero@iit.it
 * Permission is granted to copy, distribute, and/or modify this program
 * under the terms of the GNU General Public License, version 2 or any
 * later version published by the Free Software Foundation.
 *
 * A copy of the license can be found at
 * http://www.robotcub.org/icub/license/gpl.txt
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details
*/

#include "rtw_motor_config.h"
#ifdef STM32HAL_BOARD_AMCBLDC
//put here specific include files
#endif /* STM32HAL_BOARD_AMCBLDC */

void rtw_configMotor(uint8_t motor_id, uint8_t has_quad_enc, int16_t rotor_enc_resolution, uint8_t pole_pairs,
                     uint8_t has_hall_sens, uint8_t swapBC,
                     uint16_t hall_sens_offset)
{
    #ifdef STM32HAL_BOARD_AMCBLDC
    //read here the hw encoder
    #endif /* STM32HAL_BOARD_AMCBLDC */
}