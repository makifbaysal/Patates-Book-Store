package com.patates.webapi.Models.User.ManageUser;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginOutputDTO {
    private String idToken;
    private boolean isAdmin;
    private String status;
    private String name;

    public LoginOutputDTO(String status) {
        this.status = status;
    }

}
