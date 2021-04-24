package com.patates.webapi.Models.User.Bookmark;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddBookmarkInputDTO {
  private String userId;
  private String productId;
}
