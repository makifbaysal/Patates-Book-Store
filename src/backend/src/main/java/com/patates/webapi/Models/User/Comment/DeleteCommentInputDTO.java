package com.patates.webapi.Models.User.Comment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeleteCommentInputDTO {
    private String commentId;
    private String productId;
}
