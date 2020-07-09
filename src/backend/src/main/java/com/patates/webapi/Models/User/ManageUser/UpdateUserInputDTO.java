package com.patates.webapi.Models.User.ManageUser;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateUserInputDTO {

    private String idToken;
    private String email;
    private String name;
    private String phone;

}
