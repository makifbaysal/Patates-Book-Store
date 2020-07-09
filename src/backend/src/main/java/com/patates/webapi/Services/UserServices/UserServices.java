package com.patates.webapi.Services.UserServices;

import com.patates.webapi.Models.User.ManageUser.DeleteUserInputDTO;
import com.patates.webapi.Models.User.ManageUser.LoginInputDTO;
import com.patates.webapi.Models.User.ManageUser.LoginOutputDTO;
import com.patates.webapi.Models.User.ManageUser.UpdatePasswordInputDTO;

import java.io.UnsupportedEncodingException;
import java.util.concurrent.ExecutionException;

public interface UserServices {
    String signUp(String email, String password) throws UnsupportedEncodingException;

    String emailVerification(String jwtToken) throws UnsupportedEncodingException;

    String deactivateUser(DeleteUserInputDTO idToken);

    String resetPassword(String email) throws UnsupportedEncodingException, ExecutionException, InterruptedException;

    LoginOutputDTO login(LoginInputDTO loginInputDTO) throws UnsupportedEncodingException;

    String update(String email, String idToken) throws UnsupportedEncodingException;

    String updatePassword(UpdatePasswordInputDTO user) throws UnsupportedEncodingException;

}
