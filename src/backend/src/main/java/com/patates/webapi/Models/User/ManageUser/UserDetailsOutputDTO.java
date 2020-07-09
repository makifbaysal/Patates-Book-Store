package com.patates.webapi.Models.User.ManageUser;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDetailsOutputDTO {
    private String id;
    private String name;
    private String email;
    private String imageUrl;
    private String phone;
}
