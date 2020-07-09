package com.patates.webapi.Models.User.ManageUser;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdatePasswordInputDTO {
    private String idToken;
    private String password;
    private String oldPassword;

}
