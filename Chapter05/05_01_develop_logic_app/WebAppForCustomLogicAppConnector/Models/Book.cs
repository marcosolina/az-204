using System;
using TRex.Metadata;

namespace WebAppForCustomLogicAppConnector.Models
{
    public class Book
    {
        public Book()
        {
            this.Id = Guid.NewGuid();
        }

        [Metadata("Callback ID", Visibility = VisibilityType.Internal)]
        public Guid Id { get; }

        [Metadata("Title", "The title of the book")]
        public string Title { set; get; }

        [Metadata("Author", "The author of the book")]
        public string Author { set; get; }
    }
}