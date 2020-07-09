package com.patates.webapi.Models.User.Address;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeleteAddressInputDTO {
    private String userId;
    private String addressId;

}
