<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlower.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <section id="reportFraud" class="section-hero">
        <div class="container">
            <div class="row justify-content-center align-items-center py-10">
                <div class="col-lg-10 col-xl-8">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text="Enter Text To be Encrpted"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTobeEncrypt" Width="400px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" Text="Encrpted value"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEncryptedValue" Width="400px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="align-content: center">
                                <asp:Button ID="btnEncrypt" runat="server" Text="Encrypt" OnClick="btnEncrypt_Click" />
                            </td>
                        </tr>


                    </table>
                </div>
                <br />
                <div class="col-lg-10 col-xl-8">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label3" runat="server" Text="Enter Text To be Decrypted"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTobeDecrypt" Width="400px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label4" runat="server" Text="Decrpted value"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDecryptedValue" Width="400px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="align-content: center">
                                <asp:Button ID="btnDecrypt" runat="server" Text="Decrypt" OnClick="btnDecrypt_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
    </section>
    <section>
        <table>
            <tr>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="Enter the digit Number to generate Randon String with AlphaNumeric"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRandomNumber" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label6" runat="server" Text="Random String "></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtRandomString" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnGenarteRandom" runat="server" Text="Random String" OnClick="btnGenarteRandom_Click" />
                </td>
            </tr>
        </table>
        
    </section>


</asp:Content>
