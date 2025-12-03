class AuthEndpoints {
  const AuthEndpoints._();

  static const login = '/login';
}

class UserEndpoints {
  const UserEndpoints._();

  static const get = '/user';
  static const getById = '/user/id/';
  static const gets = '/users';
  static const updateById = '/user/id/';
  static const delete = '/user';
  static const deleteById = '/user/id/';
}

class UserProfileEndpoints {
  const UserProfileEndpoints._();

  static const get = '/user-profile';
  static const getById = '/user-profile/id/';
  static const update = '/user-profile';
  static const updateById = '/user-profile/id/';
}

class IVCoinEndpoints {
  const IVCoinEndpoints._();

  static const get = '/iv-coin';
  static const getById = '/iv-coin/id/';
  static const updateById = '/iv-coin/id/';
}

class AdMobEndpoints {
  const AdMobEndpoints._();

  static const addExtraIVCoins = '/ad-mob';
}

class CategoryEndpoints {
  const CategoryEndpoints._();

  static const create = '/category';
  static const getById = '/category/id/';
  static const gets = '/categories';
  static const updateById = '/category/id/';
  static const deleteById = '/category/id/';
}

class DiscountCategoryEndpoints {
  const DiscountCategoryEndpoints._();

  static const create = '/discount-category';
  static const getById = '/discount-category/id/';
  static const gets = '/discount-categories';
  static const updateById = '/discount-category/id/';
  static const deleteById = '/discount-category/id/';
}

class IVCoinPackageEndpoints {
  const IVCoinPackageEndpoints._();

  static const create = '/iv-coin-package';
  static const getById = '/iv-coin-package/id/';
  static const gets = '/iv-coin-packages';
  static const updateById = '/iv-coin-package/id/';
  static const deleteById = '/iv-coin-package/id/';
}

class InvitationThemeEndpoints {
  const InvitationThemeEndpoints._();

  static const create = '/invitation-theme';
  static const getById = '/invitation-theme/id/';
  static const gets = '/invitation-themes';
  static const getsByCategoryId = '/invitation-themes/category-id/';
  static const updateById = '/invitation-theme/id/';
  static const deleteById = '/invitation-theme/id/';
}

class DiscountEndpoints {
  const DiscountEndpoints._();

  static const setProductPrices = '/discount';
}

class ReviewEndpoints {
  const ReviewEndpoints._();

  static const create = '/review';
  static const getById = '/review/id/';
  static const gets = '/reviews';
  static const getsByInvitationThemeId = '/reviews/invitation-theme-id/';
  static const updateById = '/review/id/';
  static const deleteById = '/review/id/';
}

class InvitationEndpoints {
  const InvitationEndpoints._();

  static const create = '/invitation';
  static const getById = '/invitation/id/';
  static const gets = '/invitations';
  static const getsByUserId = '/invitations/user-id/';
  static const updateById = '/invitation/id/';
  static const deleteById = '/invitation/id/';
}

class TransactionEndpoints {
  const TransactionEndpoints._();

  static const create = '/transaction';
  static const getById = '/transaction/id/';
  static const getByReferenceNumber = '/transaction/reference-number/';
  static const gets = '/transactions';
  static const getsByUserId = '/transactions/user-id/';
  static const updateById = '/transaction/id/';
  static const deleteById = '/transaction/id/';
}

class TransactionPaymentEndpoints {
  const TransactionPaymentEndpoints._();

  static const issueById = '/transaction-payment-issue/id/';
}

class TransactionConfirmationEndpoints {
  const TransactionConfirmationEndpoints._();

  static const manualByAdminById = '/transaction-confirmation-manual/id/';
}

class TransactionStatusEndpoints {
  const TransactionStatusEndpoints._();

  static const checkByReferenceNumber = '/transaction-status-check/reference-number/';
  static const resetById = '/transaction-status-reset/id/';
}

class VoucherCodeEndpoints {
  const VoucherCodeEndpoints._();

  static const create = '/voucher-code';
  static const getById = '/voucher-code/id/';
  static const getByName = '/voucher-code/name/';
  static const gets = '/voucher-codes';
  static const updateById = '/voucher-code/id/';
  static const deleteById = '/voucher-code/id/';
}
