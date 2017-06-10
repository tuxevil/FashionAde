using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Mvc;

namespace FashionAde.Web.Common
{
    public class PagingHelper
    {
        public static Pager Paging(int totalCount, int currentPage, int pageSize, int pageCount)
        {
            Pager pager = new Pager();

            if (totalCount <= pageSize)
                return pager;

            if (currentPage == -1)
                if (totalCount % pageSize > 0)
                    currentPage = (totalCount / pageSize) + 1;
                else
                    currentPage = (totalCount / pageSize);

            int totalPages = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(totalCount) / pageSize));

            int startPosition = currentPage - (pageCount / 2);
            int endPosition = currentPage + (pageCount / 2);
            if (startPosition <= 0)
            {
                startPosition = 1;
                if (endPosition > totalPages)
                    endPosition = totalPages;
            }
            else if (endPosition > totalPages)
            {
                endPosition = totalPages;
                if (startPosition <= 0)
                    startPosition = 1;
            }

            List<SelectListItem> pages = new List<SelectListItem>();
            SelectListItem page;

            page = new SelectListItem();
            page.Text = "1";
            page.Value = "1";
            page.Selected = 1 == currentPage;
            pages.Add(page);
            if (startPosition > 2)
            {
                page = new SelectListItem();
                page.Text = "...";
                pages.Add(page);
            }

            for (int j = startPosition; j <= endPosition; j++)
            {
                if(j == 1 || j == totalPages)
                    continue;
                page = new SelectListItem();
                page.Value = j.ToString();
                page.Selected = j == currentPage;
                page.Text = j.ToString();
                pages.Add(page);
            }

            if (endPosition < totalPages - 1)
            {
                page = new SelectListItem();
                page.Text = "...";
                pages.Add(page);
            }

            page = new SelectListItem();
            page.Text = totalPages.ToString();
            page.Value = totalPages.ToString();
            page.Selected = totalPages == currentPage;
            pages.Add(page);

            pager.Pages = pages;
            pager.TotalPages = totalPages;
            pager.TotalRecords = totalCount;
            pager.PageSize = pageSize;

            return pager;
        }
    }
}
