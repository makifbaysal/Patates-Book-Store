package com.patates.webapi.Models.User.Comment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MakeCommentInputDTO {
  private String userId;
  private String productId;
  private String commentHeader;
  private String comment;
  private double star;
}
