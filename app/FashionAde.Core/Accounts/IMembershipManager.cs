namespace FashionAde.Core.Accounts
{
    /// <summary>
    /// Decouples complex access management and user validation from the model
    /// </summary>
    public interface IMembershipManager
    {
        bool LoginUser(string userName, string password);
        bool LogoutCurrentUser();
        bool ValidateUser(string userName, string password);
        bool ResetPassword(string userName);
        bool ChangePassword(string password);
    }
}