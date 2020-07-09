package com.patates.webapi.Models.Admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SeeMessageOutputDTO {
    private String email;
    private String subject;
    private String message;
}
