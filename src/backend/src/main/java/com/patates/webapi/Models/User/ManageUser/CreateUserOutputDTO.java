package com.patates.webapi.Models.User.ManageUser;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateUserOutputDTO {
    private String name;
    private String idToken;
    private String status;

}
